#!/usr/bin/env ruby
#
#

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'nokogiri'
require 'open-uri'
require 'twitter'
require 'oauth'
require 'json'
require 'pundit.rb'
require 'colorize'
require 'redis'
 
def do_the_thing last
  scorers = Array.new
  
  begin
    html = Nokogiri::HTML( open("http://www.bbc.co.uk/sport/football/live-scores/videprinter") )
  rescue
    return scorers
  end

  html.css( ".live" ).each do |score|
    if score.at_css(".col_action").text =~ /GOAL/
      who = ""
      score.at_css(".col_comment").text.gsub(/[^A-Za-z ]/i, '').split().each do |word|
        who = "#{who} #{word}" if word[0..0] =~ /[A-Z]/
      end
      
      if score.at_css(".col_status").at_css(".ht").css("strong").length == 1
        gf = ".ht"
        ga = ".at"
      else
        gf = ".at"
        ga = ".ht"
      end
      
      team_against = score.at_css(".col_status").at_css( ga ).text.tr( "0-9", "" )
      team_for     = score.at_css(".col_status").at_css( gf ).text.tr( "0-9", "" )

      message = [
                 :who     => who, 
                 :for     => team_for, 
                 :against => team_against
                ].to_json
      
      if message == last
        return scorers
      end
      scorers.unshift message
    end
  end
  return scorers
end

Twitter.configure do |config|
  config.consumer_key        = "8AwuBOOBZGVxjPwfx2StiA"
  config.consumer_secret     = "0sgTA9dVlSvKZkNceoSPtqJcAS5Xl5ITtegUVr83U"
  config.oauth_token         = ENV['JEFF_TOKEN']
  config.oauth_token_secret  = ENV['JEFF_SECRET']
end

pundit = Pundit.new
store  = Redis.new

env    = ENV['JEFF_ENV']          || nil

while true
  last    = store.get "jeff-last" || nil
  scorers = do_the_thing last

  scorers.each do |scoreline|

    tweeter = pundit.get
    message = ""

    while message.empty? or message.length > 140
      puts "The message '#{message}' is too long".red unless message.empty?
      message = tweeter.say scoreline
    end
    
    puts "#{scoreline.blue}\t\t\t::\t\t\t#{message.green}"
    store.sadd "tweets", message

    begin
      Twitter.update message if env == "live"
    rescue
      puts "Couldn't post this"
    end
    store.set "jeff-last", scoreline
    sleep 15 if env == 'live' # Flow control
  end
  
  store.save
  puts "Sleeping".magenta
  sleep 60
end

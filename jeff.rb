#!/usr/bin/env ruby
#
#

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '.', 'lib')

require 'nokogiri'
require 'open-uri'
require 'twitter'
require 'oauth'
require 'json'
require 'pundit.rb'
 
def do_the_thing last
  scorers = Array.new

  Nokogiri::HTML( open("http://www.bbc.co.uk/sport/football/live-scores/videprinter") ).css( ".live" ).each do |score|
    if score.at_css(".col_action").text =~ /GOAL/
      who = ""
      score.at_css(".col_comment").text.gsub(/[^A-Za-z ]/i, '').split().each do |word|
        who = "#{who} #{word}" if word[0..0] =~ /[A-Z]/
      end
      
      begin
        score.at_css(".col_status").at_css(".ht").css("strong")
        ga = ".at"
        gf = ".ht"
      rescue
        ga = ".ht"
        gf = ".at"
      end
      
      team_against = score.at_css(".col_status").at_css( ga ).text.tr( "0-9", "" )
      team_for     = score.at_css(".col_status").at_css( gf ).text.tr( "0-9", "" )

      message = [ :who     => who, 
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

last = ENV['JEFF_LAST'] || nil
while true
  scorers = do_the_thing last
  scorers.each do |scoreline|
    puts scoreline

    tweeter = pundit.get
    message = tweeter.say scoreline

    begin
      #Twitter.update scoreline
    rescue
      puts "Couldn't post this"
    end
    last = scoreline
    sleep 15
  end
  puts "Sleeping"
  sleep 60
end

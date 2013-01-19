#!/usr/bin/env ruby
#
#

require 'nokogiri'
require 'open-uri'
require 'twitter'
require 'oauth'
 
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
        which = ".at"
      rescue
        which = ".ht"
      end
      
      team = score.at_css(".col_status").at_css( which ).text.tr( "0-9", "" )
      message = "That #{who} loves scoring against #{team} /cc @SkySportsNews"
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

last = "That  Sturridge loves scoring against Norwich /cc @SkySportsNews"
while true
  scorers = do_the_thing last
  scorers.each do |scoreline|
    puts scoreline
    Twitter.update scoreline
    last = scoreline
    sleep 15
  end
  puts "Sleeping"
  sleep 60
end

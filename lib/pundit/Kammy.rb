#!/usr/bin/env ruby
#
# Chris Kamara - http://en.wikipedia.org/wiki/Chris_Kamara

class Kammy
  def self.say json
    parsed_json = JSON.parse( json )[0]
    case rand(99) % 3
    when 0
      return "Kammy: UNBELIEVEABLE JEFF! #{ parsed_json['who'].upcase } HAS SCORED AGAINST #{ parsed_json['against'].upcase }!"
    when 1
      return "Kammy: I'M NOT SURE, BUT I THINK THERE'S BEEN A GOAL AGAINST #{ parsed_json['against'].upcase }!"
  end
end

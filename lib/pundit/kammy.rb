#!/usr/bin/env ruby
#
# Chris Kamara - http://en.wikipedia.org/wiki/Chris_Kamara


class Kammy

  def self.say json
    parsed_json = JSON.parse( json )[0]

    [
     "Kammy: UNBELIEVEABLE JEFF! #{ parsed_json['who'].upcase } HAS SCORED AGAINST #{ parsed_json['against'].upcase }!",
     "Kammy: I'M NOT SURE, BUT I THINK THERE'S BEEN A GOAL AGAINST #{ parsed_json['against'].upcase }!",
    ].sample
  end
end

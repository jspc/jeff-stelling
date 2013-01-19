#!/usr/bin/env ruby
#
# Jeff Stelling

class Stelling
  def self.say json
    parsed_json = JSON.parse( json )[0]
    "Jeff Stelling: That #{ parsed_json['who'] } loves scoring against #{ parsed_json['against'] }!"
  end
end

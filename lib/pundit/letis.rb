#!/usr/bin/env ruby
#
# Matt 'le God' Le Tissier


class LeTis

  def self.say json
    parsed_json = JSON.parse( json )[0]

    if parsed_json['for'].downcase =~ /southampton/
      return "Le Tissier: #{ saints( parsed_json ) }"
    else
      [
       "Le Tissier: A good goal for #{parsed_json['for']} and #{parsed_json['who']} against #{parsed_json['against']}",
       "Le Tissier: Sorry Jeff I wasn't paying attention but #{parsed_json['who']} got one",
       "Le Tissier: Abysmal defending by #{parsed_json['against']} to let in #{parsed_json['who']}. Abysmal.",
      ].sample
    end
  end
    
  def self.saints json
    "Good goal for #{json['who']} but you can see the Adkins effect is lost"
  end
    
end

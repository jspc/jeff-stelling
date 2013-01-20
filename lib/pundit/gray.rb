#!/usr/bin.env ruby
#
# Andy Gray. Naughty boy


class Gray

  def self.say json
    parsed_json = JSON.parse( json )[0]

    [ 
     "Andy Gray: #{ parsed_json['against'] } just conceded to #{ parsed_json['who'] } who is now celebrating like wee jessie",
     "Andy Gray: #{ parsed_json['against'] }'s defense know as much as a woman looking at that goal they lost",
     "Andy Gray: #{ parsed_json['who'] }: What a goal! Tek a boo son, tek a boo",
     "Andy Gray: Now you dinnae want to concede like that as a #{ parsed_json['against'] } fan. Goal to  #{ parsed_json['for'] }"
    ].sample
  end
  
end

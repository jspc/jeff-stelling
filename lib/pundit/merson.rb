#!/usr/bin/env ruby
#
# Paul Merson object


class Merson

  def self.say json
    parsed_json = JSON.parse( json )[0]

    if parsed_json['for'].downcase =~ /arsenal/
      return "Paul Merson: #{ arsenal( parsed_json ) }"
    elsif parsed_json['who'].downcase =~ /agbonlahor/  
      return "Paul Merson: What a play by Agbongsawhore!"
    else
      [
       "Paul Merson: OOOAAAOOO! WHAT A GOAL! #{ mangle( parsed_json['who'].upcase ) }!",
       "Paul Merson: #{ parsed_json['who'] } is on fire! He must be on something, and I'd know!",
       "Paul Merson: #{ parsed_json['who'] } Has taken a gamble, and it's paid off, and I know gambling!",
      ].sample
    end
  end

  def self.arsenal json
    "OOOAAAOOO! WHAT A GOAL! #{ json['who'].upcase }!"
  end

  def self.mangle name
    name.gsub! "th", "sth"
    name.gsub! "k", "t"
    name.gsub! "g", ""
    name
  end

end

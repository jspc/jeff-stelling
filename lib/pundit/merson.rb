#!/usr/bin/env ruby
#
# Paul Merson object

class Merson
  def self.say json
    parsed_json = JSON.parse( json )[0]
    if parsed_json['for'].downcase =~ /arsenal/
      return "Paul Merson: #{ arsenal( parsed_json ) }"
    elsif parsed_json['who'].downcase =~ /agbonlahor/  
      return "Paul Merson: #{ agbonlahor( parsed_json) }"
    else
      case rand(99) % 3
      when 0
        return "Paul Merson: OOOAAAOOO! WHAT A GOAL! #{ mangle( parsed_json['who'].upcase ) }!"
      when 1
        return "Paul Merson: #{ parsed_json['who'] } is on fire! He must be on something, and I'd know!"
      when 2
        return "Paul Merson: "
      end
    end
  end

  def self.arsenal json
    return "OOOAAAOOO! WHAT A GOAL! #{ json['who'].upcase }!"
  end
  def self.agbonlahor json
    return "What a play by Agbongsawhore!"
  end  
  def self.mangle name
    name.gsub! "th", "sth"
    name.gsub! "k", "t"
    name.gsub! "g", ""
  end

end

#!/usr/bin/env ruby
#
# Thommo - http://en.wikipedia.org/wiki/Phil_Thompson


class Thommo

  def self.say json
    parsed_json = JSON.parse( json )[0]

    if parsed_json['for'].downcase =~ /liverpool/
      return "Phil Thompson: #{ liverpool( parsed_json ) }"
    elsif parsed_json['for'].downcase =~ /man utd/
      return "Phil Thompson: #{ united( parsed_json ) }"
    else
      [
       "Phil Thompson: Errr good goal from #{ parsed_json['who'] } for #{ parsed_json['for'] }",
       "Phil Thompson: Y'know the lad #{ parsed_json['who'] } could sign for Liverpool for that goal!",
       "Phil Thompson: **Scouse Mumblings** #{ parsed_json['for'] } **mumble** Goal! **angry threat**",
      ].sample
    end
  end

  def self.liverpool json
    "WHAT A FANTASTIC GOAL FOR THAT BOY #{ json['who'].upcase } AGAINST #{ json['against'].upcase }"
  end

  def self.united json
    "What a terrible goal for #{ json['against'] } to concede. #{ json['who'] } had no right to that"
  end

end

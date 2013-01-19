#!/usr/bin/env ruby
#
# Select a pundit and return a string based on that

#require 'pundit/cammy.rb'
#require 'pundit/merson.rb'
require 'pundit/thommo.rb'
require 'pundit/letis.rb'
require 'pundit/stelling.rb'

class Pundit
  def initialize
    @pundit = [ 
#               Cammy,
#               Merson,
               Thommo,
               LeTis,
               Stelling,
              ]
  end

  def get
    @pundit.sample
  end

end

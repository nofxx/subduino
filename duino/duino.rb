#!/usr/bin/env ruby
#
#  SCAFFOLD
#
#

require "rubygems"
require "subduino"


Subduino.start do |r|
  puts "Received #{r}"
end

# Subduino.write("Hi")


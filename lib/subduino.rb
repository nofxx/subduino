#
#
#  Arduino PubSub Hub
#
#
#
require 'serialport'
require 'stringio'
require 'readline'
require 'logger'
require 'redis'

require 'subduino/io'
require 'subduino/ps'
require 'subduino/store'
require 'subduino/arduino'

Thread.current.abort_on_exception = false

module Subduino
  Log = Logger.new("out.log")
  BAUDS = 115200   #BAUDS = 9600
  Sensors = [:temp, :lux]
  # DATA_BITS = 8
  # DATA_STOP = 1


  def self.start
    # Start some threads...
    IO.read
    PS.read

    # Be a daemon.
    loop do; end
  end

  def self.stop
    IO.stop
    PS.stop
  end

end

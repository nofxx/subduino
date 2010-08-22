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

require 'subduino/ard_io'
require 'subduino/ard_ps'
require 'subduino/parse'
require 'subduino/store'
require 'subduino/arduino'

Thread.current.abort_on_exception = false

module Subduino
  Log = Logger.new("out.log")
  BAUDS = 115200   #BAUDS = 9600
 # BAUDS = [300, 1200, 2400, 4800, 9600, 14400, 19200, 28800, 38400, 57600, 115200]
  Sensors = [:temp, :lux]
  # DATA_BITS = 8
  # DATA_STOP = 1


  def self.start(&proc)
    # Start some threads...
    ArdIO.read &proc
    ArdPS.read

    # Be a daemon.
    loop do; end
  end

  def self.stop
    ArdIO.stop
    ArdPS.stop
  end

end

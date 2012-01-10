#
#
#  Arduino PubSub Hub
#
#
#
require File.dirname(__FILE__) + '/../ext/subduino/cubduino'
#require "subduino/cubduino"
require 'serialport'
require 'eventmachine'
require 'stringio'
require 'readline'
require 'logger'
require 'redis'

require 'subduino/ard_io'
require 'subduino/ard_ps'
require 'subduino/parse'
require 'subduino/store'
require 'subduino/serial'

#Thread.current.abort_on_exception = false

module Subduino
  Log = Logger.new(const_defined?("DEBUG") ? STDOUT : "subduino-debug.log")
  # BAUDS = [300, 1200, 2400, 4800, 9600, 14400, 19200, 28800, 38400, 57600, 115200]
  # DATA_BITS = 8
  # DATA_STOP = 1


  def self.start(&proc)
    trap(:TERM) { stop! }
    trap(:INT)  { stop! }
    # Start some threads...
    Log.info "[IO] Boot!"
    ArdIO.read &proc
    Log.info "[PubSub] Boot!"
    ArdPS.read

    # Be a daemon. Should be a better way..
    # EM.run do; end
  end

  def self.stop!
    Log.info "[IO] Shutting I/O down..."
    ArdIO.stop!
    Log.info "[PubSub] Shutting PubSub down..."
    ArdPS.stop!
    exit 0
  end

end

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

LOG = Logger.new("out.log")
BAUDS = 115200
#BAUDS = 9600
DATA_BITS = 8
DATA_STOP = 1
parity = SerialPort::NONE
Thread.current.abort_on_exception = false

def halt!
  puts "Closing daemon..."
  @redis.quit
  @sp.close
  puts "OK"
  exit 0
end
trap(:TERM) { halt! }
trap(:INT)  { halt! }

def log(txt, type="info")
  LOG.send(type, txt)
end

@qi, @qo = Queue.new, Queue.new
@redis = Redis.new(:timeout => 0)
@sp = SerialPort.new("/dev/ttyUSB0", BAUDS) #, DATA_BITS, DATA_STOP, parity)
# @sp.read_timeout = 10;# @sp.write_timeout = 10

log "[USB] Starting USB Connect..." + @sp.get_modem_params.map { |k,v| "#{k}: #{v}" }.join(" ")
log "[USB] Read Timeout #{@sp.read_timeout}" # {@sp.write_timeout}"


class Arduino

  def initialize
    port_str = "/dev/tty.usbserial-A6004bX6" #may be different for you
    baud_rate = 9600
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE

    @sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
  end

  def send_to_arduino(string)
    string.to_s.chomp.split("").each do |char|
      @sp.putc char
    end
  end

  def close_connection
    @sp.close
  end
end

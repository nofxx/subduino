require 'serialport'
require 'eventmachine'
require 'redis'
require 'stringio'
require 'readline'

def halt!
  puts "Closing server"
  @redis.quit
  puts "..."
  exit
end


trap(:TERM) { halt! }
trap(:INT)  { halt! }

BAUDS = 115200
#BAUDS = 9600
DATA_BITS = 8
DATA_STOP = 1
parity = SerialPort::NONE

@redis = Redis.new(:timeout => 0)
@sp = SerialPort.new("/dev/ttyUSB0", BAUDS) #, DATA_BITS, DATA_STOP, parity)
@q = Queue.new

Thread.new do
  loop do
    while data = @sp.gets
      if data =~ /:/
        print "[COMM] #{data.sub(/\n|\r/, '')}"
        data.split(",").each do |d|
          comm, value = d.split(":")
          case comm
          when "TEMP" then  puts "#{value.to_i * 0.03} C"
          when "LIGHT" then
            puts "#{value.to_i * 2} Lux"
          else
            puts "#{comm}: #{value}"
          end
        end
      else
        puts "[ARDUINO] #{d}"
      end
    end
  end
end

EM.run do

  puts "Starting USB Connect..."
  puts @sp.modem_params
  puts @sp.get_modem_params
  puts

  Thread.new do
    @redis.subscribe('ard') do |on|
      on.subscribe {|klass, num_subs| puts "Subscribed to #{klass} (#{num_subs} subscriptions)" }
      on.message do |klass, msg|
        puts "[SUB] #{msg}"
        @q << msg
        if msg == 'exit'
          @redis.unsubscribe
        end
      end
      on.unsubscribe {|klass, num_subs| puts "Unsubscribed to #{klass} (#{num_subs} subscriptions)" }
    end
  end

  loop do
    while @q.size > 0
      puts @q.size
      tx = @q.pop
      puts @q.size
      puts "WRITING => #{tx}"
      txt = tx.sub("\n", "\r")
      txt += "\r" unless txt =~ /\\r/
      @sp.write(txt)
    end
  end

  # open("/dev/tty", "r+") { |tty|
  #   tty.sync = true
  #   # Thread.new {
  #   #   while true do
  #   #     tty.printf("%c", sp.getc)
  #   #   end
  #   # }
  #   while (l = tty.gets) do
  #     @sp.write(l.sub("\n", "\r"))
  #   end
  # }

  @sp.close


end


require 'serialport'
require 'eventmachine'
require 'redis'
require 'stringio'
require 'readline'
require 'logger'

def halt!
  puts "Closing server"
  @redis.quit
  puts "..."
  exit
end


trap(:TERM) { halt! }
trap(:INT)  { halt! }

LOG = Logger.new("out.log")
BAUDS = 115200
#BAUDS = 9600
DATA_BITS = 8
DATA_STOP = 1
parity = SerialPort::NONE

def log(txt)
  LOG.info txt
end

EM.run do
  @redis = Redis.new(:timeout => 0)
  @sp = SerialPort.new("/dev/ttyUSB0", BAUDS) #, DATA_BITS, DATA_STOP, parity)
  @qi = Queue.new
  @qo = Queue.new

  log "Starting USB Connect..."
  log @sp.modem_params
  log @sp.get_modem_params

  #
  # Read I/O
  #
  EM.defer do
    loop do
      while data = @sp.gets
        if data =~ /:/
          #  log "[COMM] #{data.sub(/\n|\r/, '')}"
          log "Reading --------------- #{Time.now.to_i}"
          data.split(",").each do |d|
            comm, value = d.split(":")
            case comm
            when "TEMP" then  log "%0.2f C" % (value.to_i * 0.03)
            when "LIGHT" then
              log "#{value.to_i * 2} Lux"
            else
              log "#{comm}: #{value}"
            end
          end
        else
          log "[ARDUINO] #{d}"
        end
      end
    end
  end

  #
  # Read PubSub
  #
  EM.defer do
    @redis.subscribe('ard') do |on|
      on.subscribe {|klass, num_subs| log "Subscribed to #{klass} (#{num_subs} subscriptions)" }
      on.message do |klass, msg|
        log "[SUB] #{msg}"
        @qi << msg
        if msg == 'exit'
          @redis.unsubscribe
        end
      end
      on.unsubscribe {|klass, num_subs| log "Unsubscribed to #{klass} (#{num_subs} subscriptions)" }
    end
  end

  #
  # Write I/O/Pubsub
  #
  loop do
    if @qi.size > 0
      tx = @qi.pop
      log "[QUEUE IN] #{@qo.size} -> #{tx}"
      txt = tx.sub("\n", "\r")
      txt += "\r" unless txt =~ /\\r/
      @sp.write(txt)
    end
    if @qo.size > 0
      log "[QUEUE OUT] #{@qo.size}"
      # publish pubsub
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


  # end

end

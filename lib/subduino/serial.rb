module Subduino

  class Serial
    attr_reader :sp, :port, :bauds

    def initialize(bauds = 57600)
      @bauds = bauds
      @port = find_port
      @sp ||= SerialPort.new(@port, bauds) #, DATA_BITS, DATA_STOP, parity)
      # @sp.read_timeout  = 10
      # @sp.write_timeout = 10
    end

    def find_port
      prefix = RUBY_PLATFORM =~ /darwin/ ? ".usbmodem" : "USB"
      port =  Dir.glob("/dev/tty#{prefix}*").first
      raise "Can't find serial port" unless port
      port
    end

    def read
      sp.getc
    end

    def write msg
      # txt += "\n" unless txt =~ /^\\n/
      txt = msg.gsub("\r|\n", "")
      Log.debug "=> Sending #{txt.inspect}"
      sp.puts txt
      # msg.to_s.chomp.split("").each do |char|
      # @sp.putc char
    end

    def up?
      sp
    end

    def kill
      sp.close
    end

  end

end

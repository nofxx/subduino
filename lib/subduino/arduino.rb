module Subduino



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

  end
end

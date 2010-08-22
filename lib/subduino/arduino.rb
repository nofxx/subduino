module Subduino



  class Arduino

    def self.find_usb
      Dir['/dev/ttyUSB*'].first
    end


    def initialize
    end

    def send_to_arduino(string)
      string.to_s.chomp.split("").each do |char|
        @sp.putc char
      end
    end

  end

                      #   read << case comm
                      # when "Temp"  then  "%0.2f C" % (value.to_i * 0.04)
                      # when "Light" then  "#{value.to_i * 2} Lux"
                      # else
                      #   "#{comm}: #{value}"
                      # end

end

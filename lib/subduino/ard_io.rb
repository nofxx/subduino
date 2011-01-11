module Subduino

  class ArdIO
    class << self

      #
      # Serial Port
      #
      # Direct access to the SerialPort instance.
      #
      def sp
        @sp ||= SerialPort.new(Arduino.find_usb, AppConfig[:bauds] || 115200) #, DATA_BITS, DATA_STOP, parity)
        # @sp.read_timeout = 10;# @sp.write_timeout = 10
      end

      #
      # Read I/O
      #
      # Starts a thread that loops fetching serial bytes.
      # It'll buffer it up until a \n or \r char are found.
      # Feed it with a block to read the text.
      #
      def read(&proc)
        Log.info "[USB] Starting USB Connect..." + sp.get_modem_params.map { |k,v| "#{k}: #{v}" }.join(" ")
        Log.info "[USB] Read Timeout #{sp.read_timeout}" # {sp.write_timeout}"

        if sp
        @iothread ||= Thread.new do
          Thread.current.abort_on_exception = false
          icache = []
          loop do
            begin
              while char = sp.getc
                if !char.valid_encoding?
                  bytes = char.bytes.to_a
                  hexes = bytes.map { |b| b.to_s(16) }
                  puts " - Bad char #{char} - (Hex: #{char.unpack('H')} | Byte(s) #{bytes} | Hexe(s) #{hexes}"
                elsif char !~ /\n|\r/
                  # print char if Debug
                  icache << char
                else
                  data = icache.join(""); icache = []
                  unless data.empty?
                    Log.info "[IO  RX] #{data}"
                    proc.call(data)
                  end
                end
                # sleep 1
              end
            rescue => e
              Log.error "[USB] Error #{e}"
              Log.error e.backtrace.join("\n")
            end
          end
        end
        end

      end

      #
      # Write I/O
      #
      # Prints bytes to the serial port.
      # It'll use subduino convention of \n to end the message.
      # Use #sp to write directly to the port. `ArdIO.sp.puts ('hi')`
      #
      def write(msg)
        Log.info "[IO  TX] #{msg}"
        txt = msg.gsub("\r|\n", "")
       # txt += "\n" unless txt =~ /^\\n/
        puts "=> Sending #{txt.inspect}" if Debug
        sp.puts(msg)
      end


      #
      # Finish Him!
      #
      def stop!
        sp.close
      end

    end
  end
end

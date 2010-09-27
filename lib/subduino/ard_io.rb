module Subduino

  class ArdIO
    class << self

      def sp
        @sp ||= SerialPort.new(Arduino.find_usb, BAUDS) #, DATA_BITS, DATA_STOP, parity)
        # @sp.read_timeout = 10;# @sp.write_timeout = 10
      end

      def read(&proc)
        Log.info "[USB] Starting USB Connect..." + sp.get_modem_params.map { |k,v| "#{k}: #{v}" }.join(" ")
        Log.info "[USB] Read Timeout #{sp.read_timeout}" # {sp.write_timeout}"

        #
        # Read I/O
        #
        @iothread ||= Thread.new do
          Thread.current.abort_on_exception = false
          icache = []

          begin
            while char = sp.getc
              if char !~ /\n|\r/
                icache << char
              else
                data = icache.join(""); icache = []
                if data =~ /:/
                  proc.call(data)
                  Log.info "[IO  RX] #{data}"
                else
                  unless data.empty?
                    Log.info "[IO  RX] #{data}"
                    proc.call(data)
                  end
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

      def write(msg)
        Log.info "[IO  TX] #{msg}"
        txt = msg.gsub("\n", "\n\r")
        txt += "\n\r" unless txt =~ /^\\r/
        p txt + txt
        sp.write(txt)
      end

      def stop!
        sp.close
      end

    end
  end
end

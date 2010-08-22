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
        Thread.new do
          Thread.current.abort_on_exception = false
          icache = []

          loop do
            begin
              if char = sp.getc
                if char !~ /\n|\r/
                  icache << char
                else
                  data = icache.join(""); icache = []
                  if data =~ /:/
                    read = []
                    Log.info "[IO  RX] --------------- #{Time.now.to_i}"
                    data.split(",").each do |d|
                      comm, value = d.split(":")
                      Store.write(comm, value)
                      read << "#{comm}: #{value}"
                    end
                    txt = read.join(", ")
                    proc.call(txt)
                    Log.info "[SENSOR] #{txt}"
                  else
                    # Log.info "[INPUT] Done."
                  end
                end
              end
            rescue => e
              Log.error "[USB] Error #{e}"
              Log.error e.backtrace.join("\n")
            end
          end
        end
      end

      def write(msg)
        Log.info "[IO  TX] #{msg}"
        txt = msg.sub("\n", "\r")
        txt += "\r" unless txt =~ /\\r/
        sp.write(txt)
      end

    end
  end
end

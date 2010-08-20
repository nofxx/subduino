module Subduino

  class IO
    class << self

      def sp
        @sp ||= SerialPort.new("/dev/ttyUSB0", BAUDS) #, DATA_BITS, DATA_STOP, parity)
        # @sp.read_timeout = 10;# @sp.write_timeout = 10
      end

      def read
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
                    Log.info "[INPUT] --------------- #{Time.now.to_i}"
                    data.split(",").each do |d|
                      comm, value = d.split(":")
                      read << case comm
                      when "Temp"  then  "%0.2f C" % (value.to_i * 0.04)
                      when "Light" then  "#{value.to_i * 2} Lux"
                      else
                        "#{comm}: #{value}"
                      end
                    end
                    Log.info "[SENSOR] " + read.join(", ")
                  else
                    Log.info "[INPUT] Done."
                  end
                end
              end
            rescue => e
              Log.error "[USB] Error #{e} #{e.backtrace}"
            end
          end
        end
      end

      def write(msg)
        Log.info "[IO TX] #{msg}"
        txt = msg.sub("\n", "\r")
        txt += "\r" unless txt =~ /\\r/
        sp.write(txt)
      end

    end
  end
end

module Subduino

  class ArdPS
    class << self

      #
      # Redis PubSub
      #
      # Direct access to the Redis instance.
      #
      def redis
        @redis ||= Redis.new(:timeout => 0)
      end

      #
      # Read PubSub
      #
      # Join 'subduino' channel and send messages to I/O
      #
      def read
        return Log.warn "[PubSub] Not started..." unless redis
        @psthread = Thread.new do
          begin
            redis.subscribe('subduino') do |on|
              on.subscribe {|klass, num_subs| Log.info "[PubSub] Subscribed to #{klass} (#{num_subs} subscriptions)" }
              on.message do |klass, msg|
                Log.info "[PubSub] #{klass} - #{msg}"
                ArdIO.write msg
                # @redis.unsubscribe if msg == 'exit'
              end
              on.unsubscribe {|klass, num_subs| Log.info "[PubSub] Unsubscribed to #{klass} (#{num_subs} subscriptions)" }
            end
          rescue => e
            Log.error "[PubSub] Error #{e}"
            Log.error e.backtrace.join("\n")
            exit 1
          end

        end
      end

      #
      # Write PubSub
      #
      # Write a message to the 'subduino' PubSub channel.
      #
      def write(msg)
        redis.publish('subduino', msg)
      end


      #
      # Fatality
      #
      def stop!
        Thread.kill @psthread
        redis.disconnect if redis
        Log.info "[PubSub] K.I.A"
      end

    end
  end

end

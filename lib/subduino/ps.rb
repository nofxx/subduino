module Subduino
  class PS

    def self.read
      Thread.new do
        begin
          Subduino.redis.subscribe('ard') do |on|
            on.subscribe {|klass, num_subs| Log.info "[PubSub] Subscribed to #{klass} (#{num_subs} subscriptions)" }
            on.message do |klass, msg|
              Log.info "[PubSub] #{msg}"
              IO.write msg
              # @redis.unsubscribe if msg == 'exit'
            end
            on.unsubscribe {|klass, num_subs| Log.info "[PubSub] Unsubscribed to #{klass} (#{num_subs} subscriptions)" }
          end
        rescue => e
          Log.error "[PubSub] Error #{e} #{e.backtrace}"
        end

      end
    end

    def self.write(msg)
      Subduino.redis.publish('ard', msg)
    end

  end
end

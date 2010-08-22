module Subduino
  class ArdPS

    def self.redis
      @redis ||= Redis.new(:timeout => 0)
    end

    def self.read
      Thread.new do
        begin
          redis.subscribe('subduin') do |on|
            on.subscribe {|klass, num_subs| Log.info "[PubSub] Subscribed to #{klass} (#{num_subs} subscriptions)" }
            on.message do |klass, msg|
              Log.info "[PubSub] #{klass} - #{msg}"
              ArdIO.write msg
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
      redis.publish('subdout', msg)
    end

  end
end

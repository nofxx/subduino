#
#  Subduino Persistent Store
#
#
#  Uses redis to store.
#  Maybe Tokyo/PG support in the future...
#
module Subduino
  class Store
    class << self

      def redis
        @redis ||= Redis.new(:timeout => 0)
      end


      def read(key)
        redis.get key
      end

      def write(key, val=nil)
        if val
          add_to_store key, val
        else
          key.each do |k,v|
            add_to_store k, v
          end
        end
      end

      def add_to_store(k, v)
        redis.set k, v
        redis.rpush "#{k}_log", v
      end


      # def method_missing(*args)
      #   read(args[0])
      # end

    end
  end
end

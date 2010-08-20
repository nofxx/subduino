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
          redis.set key, val
        else
          key.each do |k,v|
            redis.set k, v
          end
        end
      end


      # def method_missing(*args)
      #   read(args[0])
      # end

    end
  end
end

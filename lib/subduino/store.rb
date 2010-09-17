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
        @redis ||= Redis.new(:timeout => 0) rescue false
      end

      def read(key)
        redis.get key
      end

      def write(k, v)
        return unless redis #.connected?
        redis.set k, v
        redis.rpush "#{k}_log", v
      end

      def add_to_store(key, val=nil)
        if val
          write key, val
        else
          key.each do |k,v|
            write k, v
          end
        end
      end

      def add_csv_to_store(csv)
        Log.info "[STORE] CSV #{Time.now.to_i}"
        csv.split(",").each do |d|
          comm, value = d.split(":")
          write(comm, value)
        end
      end

      def count
        redis.dbsize
      end

      def flush
        redis.flushdb
        #redis.flushall
      end

      def all
        redis.keys
      end


      # def method_missing(*args)
      #   read(args[0])
      # end

    end
  end
end

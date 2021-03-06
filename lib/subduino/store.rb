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
        redis.get key.to_s
      end

      def timestamp
        Time.now.to_i.to_s
      end

      def write(k, v, stamp = false)
        return unless redis #.connected?
        stamp ?  redis.rpush("log:inputs:#{k}", "#{timestamp}:#{v}") : redis.set("now:inputs:#{k}", v)
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

      def add_csv_to_store(csv, stamp = false)
        # Log.info "[STORE] CSV #{Time.now.to_i}"
        csv.split(",").each do |d|
          comm, value = d.split(":")
          write(comm, value, stamp)
        end
      end

      # SORT key [BY pattern] [LIMIT start count] [GET pattern]
      # [ASC|DESC] [ALPHA] [STORE dstkey]
      def read_hist(key, period, offset = 0, max = 100)
        redis.sort key, { :order => 'desc', :limit => [offset, max] }
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

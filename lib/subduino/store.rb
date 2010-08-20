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
      
      def read(key)
      end

      def write(key, val)
      end


      # def method_missing(*args)
      #   read(args[0])
      # end
      
    end
  end
end

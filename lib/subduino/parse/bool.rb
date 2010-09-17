module Subduino
  module Parse
    class Bool < DigParser
      def parse
        @v.zero? ? false : true
      end

      def to_s
        parse ? "ON" : "OFF"
      end
    end
  end
end

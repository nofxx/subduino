module Subduino
  module Parse
    class Energy < Analogic
      AC = 220
      def parse
        (@v / 10).to_i
      end

      def kwh
        AC * parse
      end

      def to_s
        "#{parse} A"
      end
    end
  end
end

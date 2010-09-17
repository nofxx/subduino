module Subduino
  module Parse
    class Lux < AnaParser
      def parse
        (@v * 0.5).to_i
      end

      def to_s
        "#{parse} L"
      end
    end
  end
end

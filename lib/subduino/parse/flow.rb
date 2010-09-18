module Subduino
  module Parse
    class Flow < Analogic
      def parse
        (@v * 0.5).to_i
      end

      def to_s
        "#{parse} cm3/h"
      end
    end
  end
end

module Subduino
  module Parse
    class Pressure < Analogic
      def parse
        (@v * 0.5).to_i
      end

      def to_s
        "#{parse} psi"
      end
    end
  end
end

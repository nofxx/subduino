# -*- coding: utf-8 -*-
module Subduino
  module Parse

    class Temp < AnaParser
      def parse
        @v * 0.035
      end

      def to_s
        "%0.2f°C" % parse
      end
    end


  end
end

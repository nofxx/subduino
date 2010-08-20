# -*- coding: utf-8 -*-
module Subduino
  module Parse

    def self.work(klass, v)
      const_get(klass).new(v)
    end

    class DigParser
      def initialize(v); @v = v;  end
      def digital?; true;   end
      def to_s; @v.to_s; end
      def raw; @v; end
    end

    class AnaParser < DigParser
      def digital?; false;   end
      def parse; @v.to_i;  end
    end

    class Bool < DigParser
      def parse
        @v.to_i.zero? ? true : false
      end

      def to_s
        parse ? "ON" : "OFF"
      end
    end

    class Knob < AnaParser
    end

    class Temp < AnaParser
      def parse
        @v.to_i * 0.035
      end

      def to_s
        "%0.2f°C" % parse
      end
    end

    class Lux < AnaParser
      def parse
        (@v.to_i * 0.5).to_i
      end

      def to_s
        "#{parse} L"
      end
    end



  end
end

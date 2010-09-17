# -*- coding: utf-8 -*-
module Subduino
  module Parse

    def self.work(klass, v, name=nil)
      const_get(klass).new(v, name)
    end

    class DigParser
      def initialize(v,n=nil)
        @v = v.to_i
        @name = n
      end
      def digital?; true;   end
      def to_s; @v.to_s; end
      def name; @name; end
      def type
        self.class.to_s.split("::")[-1].downcase # ugly
      end
      def raw; @v; end
    end

    class AnaParser < DigParser
      def digital?; false;   end
      def parse; @v;    end
      def ratio
        return 0 if @v.zero?
        @v * 100 / 1023
      end
    end

    class Bool < DigParser
      def parse
        @v.zero? ? false : true
      end

      def to_s
        parse ? "ON" : "OFF"
      end
    end

    class Knob < AnaParser
    end

    class Temp < AnaParser
      def parse
        @v * 0.035
      end

      def to_s
        "%0.2f°C" % parse
      end
    end

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

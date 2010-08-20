# -*- coding: utf-8 -*-
module Subduino
  module Parse

    def self.work(klass, v)
      const_get(klass).new(v)
    end

    class DigParser
      def initialize(v); @v = v;  end
    end

    class AnaParser < DigParser
      def parse; @v.to_i;  end
    end

    class Bool < DigParser
      def parse
        @v.to_i.zero? ? true : false
      end
    end

    class Temp < AnaParser
      def to_s
        "#{parse}°C"
      end
    end

    class Lux < AnaParser
      def to_s
        "#{parse} L"
      end
    end



  end
end

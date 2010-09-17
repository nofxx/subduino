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

    class Knob < AnaParser
    end


  end
end

Dir[File.dirname(__FILE__) + "/parse/*.rb"].each { |f| require f}

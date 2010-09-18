# -*- coding: utf-8 -*-
module Subduino
  module Parse

    def self.work(klass, v, name=nil, id=nil)
      const_get(klass).new(v, name, id)
    end

    class Digital
      def initialize(v,n=nil,id=nil)
        @v = v.to_i
        @id = id
        @name = n
      end
      def digital?; true;   end
      def to_s; @v.to_s; end
      def name; @name; end
      def type
        self.class.to_s.split("::")[-1].downcase # ugly
      end
      def raw; @v; end

      def sparkline(range = [-50, -1])
        Store.redis.lrange "#{@id}_log", *range
      end

      def graph(period)
        Store.redis
      end


    end

    class Analogic < Digital
      def digital?; false;   end
      def parse; @v;    end
      def ratio
        return 0 if @v.zero?
        @v * 100 / 1023
      end
    end

    class Knob < Analogic
    end


  end
end

Dir[File.dirname(__FILE__) + "/parse/*.rb"].each { |f| require f}

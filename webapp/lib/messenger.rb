module Messenger
  class Message
    PINS = (0..12).to_a
    LOW  = 0
    HIGH = 250

    def initialize(txt=nil)
      @txt = PINS.map { |p| txt ? HIGH : LOW }.join(" ")
    end

    def txt
      @txt
    end
  end

end

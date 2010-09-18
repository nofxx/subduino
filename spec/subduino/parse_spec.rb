require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parse do
  include Parse

  it "should parse digital" do
    d = Digital.new(8)
    d.should be_digital
  end

  it "should parse digital" do
    d = Bool.new(8)
    d.to_s.should eql("ON")
  end

  it "should parse analog ratio" do
    d = Knob.new(1023)
    d.ratio.should eql(100)
  end

end

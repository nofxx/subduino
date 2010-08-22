require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Parse do
  include Parse

  it "should parse digital" do
    d = DigParser.new(8)
    d.should be_digital
  end

  it "should parse digital" do
    d = Bool.new(8)
    d.to_s.should eql("OFF")
  end

end

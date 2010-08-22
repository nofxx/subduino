require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Store" do

  it "should write things" do
    Store.flush
    Store.write(:temp, 18)
    Store.count.should eql(2)
  end

  it "should read" do
    Store.read(:temp).should eql("18")
  end

  it "should read array"

end

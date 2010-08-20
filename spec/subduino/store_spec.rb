require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe "Store" do

  it "should write things" do
    Store.write(:temp, 18)
    Store.count.should eql(1)
  end

  

end

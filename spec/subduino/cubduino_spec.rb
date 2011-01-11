require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Cubduino" do

  it "should define module" do
    Subduino.const_defined?("Cubduino").should be_true
  end


end

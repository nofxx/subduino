require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Subduino" do

  it "should be a module" do
    Subduino.should be_a Module
  end

  it "should have io" do
    Subduino.should be_const_defined :IO
  end

  it "should have pubsub" do
    Subduino.should be_const_defined :PS
  end

  it "should autostart redis"


end

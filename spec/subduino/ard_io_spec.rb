require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ArdIO do

  it "should start serial port" do
    SerialPort.should_receive(:new).with("/dev/ttyUSB0", 115200)
    ArdIO.sp
  end
end

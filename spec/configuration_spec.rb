#encoding: utf-8
require "spec_helper"

describe CustomCaptcha::Configuration do

  it "should set a configuration" do
    CustomCaptcha::Configuration.text_length.should == 5
    CustomCaptcha.configure do |config|
      config.text_length = 6
    end
    CustomCaptcha::Configuration.text_length.should == 6
  end

  it "should define images path" do
    CustomCaptcha::Configuration.images_path_definite.should be_true
  end
end


#encoding: utf-8
require "spec_helper"

describe CustomCaptcha::Image do

  it "should create a image" do
    CustomCaptcha::Image.create().should be_true
  end
end


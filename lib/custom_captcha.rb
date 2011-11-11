require "active_support/concern"
require "active_support/core_ext/object"
require "active_support/core_ext/class/attribute_accessors"
require "active_support/core_ext/module/attribute_accessors"
require "securerandom"
require "RMagick"
include Magick
require "tmpdir"
require "fileutils"
require "digest/md5"
require "find"

require 'custom_captcha/errors'
require 'custom_captcha/version'
require 'custom_captcha/configuration'
require 'custom_captcha/utils'
require 'custom_captcha/image'

require "custom_captcha/engine"
require "custom_captcha/railtie"

module CustomCaptcha
  DEFAULTVALUE = {
    :field_name => :custom_captcha,
    :key_name => :custom_captcha_key,
    :key_id => :custom_captcha_key,
    :img_id => :custom_captcha_img,
    :template => 'default'
  }
  class << self
    def configure(&block)
      CustomCaptcha::Configuration.configure(&block)
    end
  end
  # init configuration
  CustomCaptcha::Configuration.init_config()
end


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

if defined?(::Rails)
  if ::Rails.version < "3.0"
    raise RailsVersionError, "mast use rails 3.0+"
  else
    require "custom_captcha/engine"
    require "custom_captcha/railtie"
  end
end


module CustomCaptcha
  class << self
    def configure(&block)
      CustomCaptcha::Configuration.configure(&block)
    end
  end
  # init configuration
  CustomCaptcha::Configuration.init_config()
end


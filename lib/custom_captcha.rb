require "active_support/concern"
require "active_support/core_ext/object"
require "active_support/core_ext/class/attribute_accessors"
require "active_support/core_ext/module/attribute_accessors"
require "securerandom"
require "RMagick"
include Magick
require "mini_magick"
require "tmpdir"
require "fileutils"
require "digest/md5"


module CustomCaptcha
  require 'custom_captcha/errors'
  autoload :VERSION, 'custom_captcha/version'
  autoload :Configuration, 'custom_captcha/configuration'
  autoload :Utils, 'custom_captcha/utils'
  autoload :Image, 'custom_captcha/image'

  class << self
    def configure(&block)
      CustomCaptcha::Configuration.configure(&block)
      # make and define captcha images path
      CustomCaptcha::Configuration.make_and_define_images_path()
    end
  end

  # init configuration
  CustomCaptcha::Configuration.init_config()
  # make and define captcha images path
  CustomCaptcha::Configuration.make_and_define_images_path()

  if defined?(::Rails)
    if ::Rails.version < "3.0"
      raise RailsVersionError, "mast use rails 3.0+"
    else
      if ::Rails.version < "3.1"
        require "custom_captcha/rails/railtie"
      else
        require "custom_captcha/rails/engine"
      end
    end
  end

end


require "active_support/concern"
require "active_support/core_ext/object"
require "active_support/core_ext/class/attribute_accessors"
require "active_support/core_ext/module/attribute_accessors"
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
    end
  end


  # init configuration
  CustomCaptcha::Configuration.init_config()
  # make and define captcha images path
  CustomCaptcha::Configuration.make_and_define_images_path()

  if defined?(::Rails)
  end

end


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
require "find"

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

  if defined?(::Rails)
    if ::Rails.version < "3.0"
      raise RailsVersionError, "mast use rails 3.0+"
    else
      require "custom_captcha/rails_railtie"
    end
  end unless File.exist?(File.expand_path('../../config/application.rb', __FILE__))

  # init configuration
  CustomCaptcha::Configuration.init_config()

end


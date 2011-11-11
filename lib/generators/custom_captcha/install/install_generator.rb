require File.expand_path('../../utils', __FILE__)

class CustomCaptcha::InstallGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  include CustomCaptcha::Generators::Utils::InstanceMethods

  desc "Creates CustomCaptcha initializer and copy locale files to your application."

  def create_initializer
    data_custom_captcha_rb = %Q/
CustomCaptcha.configure do |config|
  config.image_columns  = 120
  config.image_rows     = 40
  config.image_style    = "simply_blue"
  config.text_range     = ("a".."z").to_a
  config.text_length    = 5
  config.images_path    = Rails.root.join("public", "system", "captcha_images").to_s
  config.enable         = true
  config.salt           = "#{ SecureRandom.hex(20) }"
end
    /
    initializer "custom_captcha.rb", data_custom_captcha_rb
  end

  def create_locale
    copy_file "../../../../../config/locales/custom_captcha.en.yml", "config/locales/custom_captcha.en.yml"
  end

  def create_views
    filename_pattern = File.expand_path("../../../../../app/views/custom_captcha/captcha_styles/*", __FILE__)
    Dir[filename_pattern].each do |f|
      copy_file f, "app/views/custom_captcha/captcha_styles/#{File.basename f}"
    end
  end

  def test_rakes
    display "test generate and clear images..."
    rake("custom_captcha:generate_images[1]")
    rake("custom_captcha:clear_images")
  end

  def show_readme
    display "Succeed! custom_captcha has been installed."
    readme("README")
  end
end


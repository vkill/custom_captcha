require File.expand_path('../../utils', __FILE__)

class CustomCaptcha::UninstallGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  include CustomCaptcha::Generators::Utils::InstanceMethods

  desc "Remove CustomCaptcha initializer and remove locale files from your application."

  def clear_images
    rake("custom_captcha:clear_images")
  end

  def destroy_initializer
    remove_file "config/initializers/custom_captcha.rb"
  end

  def destroy_locale
    remove_file "config/locales/custom_captcha.en.yml"
  end

  def destroy_views
#    filename_pattern = File.expand_path("../../../../../app/views/custom_captcha/captcha_styles/*", __FILE__)
#    Dir[filename_pattern].each do |f|
#      copy_file f, "app/views/custom_captcha/captcha_styles/#{File.basename f}"
#    end
    Dir["app/views/custom_captcha/captcha_styles/*"].each do |f|
      remove_file f
    end
  end

  def show_readme
    display "Done! custom_captcha has been uninstalled."
    readme("README")
  end
end


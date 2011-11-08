require File.expand_path('../../utils', __FILE__)

class CustomCaptcha::UninstallGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  include CustomCaptcha::Generators::Utils::InstanceMethods

  desc "Remove CustomCaptcha initializer and remove locale files from your application."

  def uninstall
    rake("custom_captcha:clear_all_images")
    remove_file "config/initializers/custom_captcha.rb"
    remove_file "config/locales/custom_captcha.en.yml"
    display "Done! custom_captcha has been uninstalled."
  end

  def show_readme
    readme("README")
  end
end


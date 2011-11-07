require File.expand_path('../../utils', __FILE__)

class CustomCaptcha::InstallGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  include CustomCaptcha::Generators::Utils::InstanceMethods

  desc "Creates CustomCaptcha initializer and copy locale files to your application."

  def install
    template "config/initializers/custom_captcha.rb", "config/initializers/custom_captcha.rb"
    copy_file "../../../../../config/locales/custom_captcha.en.yml", "config/locales/custom_captcha.en.yml"
    rake("custom_captcha:generate")
    display "Succeed! custom_captcha has been installed."
  end

  def show_readme
    readme("README")
  end
end


class CustomCaptcha::InstallGenerator < Rails::Generators::NamedBase

  source_root File.expand_path('../templates', __FILE__)

  desc "Creates a CustomCaptcha initializer and copy locale files to your application."

  def copy_initializer_file
    copy_file "config/initializers/custom_captcha.rb", "config/initializers/#{file_name}.rb"
  end

  def copy_locale_file
    copy_file "../../../config/locales/custom_captcha.en.yml", "config/locales/custom_captcha.en.yml"
  end

  def run_rake
    rake("custom_captcha:generate")
  end

  def show_readme
    readme("README")
  end
end


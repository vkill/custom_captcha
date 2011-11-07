module CustomCaptcha
  class RailsRailtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/custom_captcha_utils.rake"
    end
  end
end


require 'custom_captcha/common_methods'
require 'custom_captcha/action_controller_extension'
require 'custom_captcha/action_view_extension'
require 'custom_captcha/active_record_extension'

module CustomCaptcha
  class Railtie < ::Rails::Railtie
    initializer 'custom_captcha' do |app|
      ActiveSupport.on_load :action_controller do
        ActionController::Base.send :include, CustomCaptcha::ActionControllerExtension
      end

      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, CustomCaptcha::ActionViewExtension::Base
        ActionView::Helpers::FormBuilder.send :include,
                                CustomCaptcha::ActionViewExtension::Helpers::FormBuilder
      end

      ActiveSupport.on_load :active_record do
        include CustomCaptcha::ActiveRecordExtension
      end
    end
  end
end


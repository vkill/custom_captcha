module CustomCaptcha
  module ActionControllerExtension
    extend ActiveSupport::Concern
    included do
      include CustomCaptcha::CommonMethods
      helper_method "set_captcha_session", "captcha_session"
    end
    module ClassMethods
    end
    module InstanceMethods
      def custom_captcha_valid?(captcha_text=nil)
        if CustomCaptcha::Configuration.disable? or Rails.env.test?
          return true
        end
        captcha_text ||= params[:custom_captcha]
        if captcha_text
          CustomCaptcha::Utils.captcha_value_valid?(captcha_text, captcha_session())
        else
          return false
        end
      end

      def set_captcha_session(text)
        session[:captcha_digested] = text
      end

      def captcha_session()
        session[:captcha_digested]
      end
    end
  end
end


module CustomCaptcha
  module ActionControllerExtension
    extend ActiveSupport::Concern
    included do
      include CustomCaptcha::CommonMethods
      helper_method :choice_image_file_path_and_write_session_cache,
                    :read_captcha_digested, :read_image_file_path
    end
    module ClassMethods
    end
    module InstanceMethods
      def custom_captcha_valid?(captcha_value=nil)
        if CustomCaptcha::Configuration.disable? or Rails.env.test?
          return true
        end
        captcha_value ||= params[CustomCaptcha::DEFAULTVALUE[:field_name]]
        if captcha_value
          CustomCaptcha::Utils.captcha_value_valid?(captcha_value, read_captcha_digested())
        else
          return false
        end
      end

      def choice_image_file_path_and_write_session_cache
        image_file_path, captcha_digested, key =
                  CustomCaptcha::Utils.choice_image_file_path_and_generate_captcha_digested_key
        session[:captcha_digested] = captcha_digested
        Rails.cache.write(key, [image_file_path, captcha_digested])
        key
      end

      def read_captcha_digested
        session[:captcha_digested]
      end

      def read_image_file_path(key)
        Rails.cache.read(key)[0] rescue nil
      end
    end
  end
end


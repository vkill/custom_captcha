module CustomCaptcha
  module ActiveRecordExtension
    extend ActiveSupport::Concern
    included do
      include CustomCaptcha::CommonMethods
      extend ClassMethods
    end
    module ClassMethods
      def apply_custom_captcha
        attr_accessor :custom_captcha, :custom_captcha_image_file_key

        after_initialize do
          after_initialize if custom_captcha_need_valid?
        end

        validate :valid_custom_captcha, :if => :custom_captcha_need_valid?

        include CustomCaptcha::ActiveRecordExtension::InstanceMethods
      end
    end
    module InstanceMethods
      def after_initialize
        @custom_captcha_image_file_key = CustomCaptcha::Utils.choice_image_file_key_by_rand()
      end

      def valid_custom_captcha
        custom_captcha_digested = CustomCaptcha::Utils.generate_captcha_digested(custom_captcha_image_file_key)
        unless CustomCaptcha::Utils.captcha_value_valid?(custom_captcha, custom_captcha_digested)
          errors.add(:custom_captcha, I18n.t('custom_captcha.message'))
        end
      end

      def custom_captcha_need_valid?
        !CustomCaptcha::Configuration.disable? and !Rails.env.test?
      end
    end
  end
end


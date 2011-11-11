module CustomCaptcha
  module ActiveRecordExtension
    extend ActiveSupport::Concern
    included do
      include CustomCaptcha::CommonMethods
      extend ClassMethods
    end
    module ClassMethods
      def apply_custom_captcha
        attr_accessor :custom_captcha, :custom_captcha_key

        after_initialize do
          after_initialize if custom_captcha_need_valid?
        end

        validate :valid_custom_captcha, :if => :custom_captcha_need_valid?

        include CustomCaptcha::ActiveRecordExtension::InstanceMethods
      end
    end
    module InstanceMethods
      def after_initialize
        self.custom_captcha_key ||= choice_image_file_path_and_write_cache
      end

      def valid_custom_captcha
        unless CustomCaptcha::Utils.captcha_value_valid?(custom_captcha, read_captcha_digested())
          errors.add(:custom_captcha, I18n.t('custom_captcha.message'))
        end
      end

      def custom_captcha_need_valid?
        !CustomCaptcha::Configuration.disable? and !Rails.env.test?
      end

      private
        def choice_image_file_path_and_write_cache
          image_file_path, captcha_digested, key =
                    CustomCaptcha::Utils.choice_image_file_path_and_generate_captcha_digested_key
          Rails.cache.write(key, [image_file_path, captcha_digested])
          key
        end

        def read_captcha_digested
          Rails.cache.read(self.custom_captcha_key)[1] rescue ""
        end

    end
  end
end


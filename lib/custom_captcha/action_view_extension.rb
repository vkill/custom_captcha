module CustomCaptcha
  module ActionViewExtension
    module Base
      extend ActiveSupport::Concern
      included do
        include CustomCaptcha::CommonMethods
      end
      module ClassMethods
      end
      module InstanceMethods
        def display_custom_captcha(options={})
          return "" if CustomCaptcha::Configuration.disable?
          options[:key] = choice_image_file_path_and_write_session_cache

          options[:field_name] ||= CustomCaptcha::DEFAULTVALUE[:field_name]
          options[:key_name] ||= CustomCaptcha::DEFAULTVALUE[:key_name]
          options[:key_id] ||= CustomCaptcha::DEFAULTVALUE[:key_id]
          options[:img_id] ||= CustomCaptcha::DEFAULTVALUE[:img_id]

          options[:img_src] = show_captcha_image_path(options[:key])
          options[:template] ||= CustomCaptcha::DEFAULTVALUE[:template]
          options[:label_text] ||= I18n.t('custom_captcha.label')
          options[:change_text] ||= I18n.t('custom_captcha.change')
          options[:change_url] = change_captcha_images_path(:img_id => options[:img_id], :key_id => options[:key_id])
          render "custom_captcha/captcha_styles/#{options[:template].to_s}", :captcha => options
        end
      end
    end

    module Helpers
      module FormBuilder
        extend ActiveSupport::Concern
        included do
          include CustomCaptcha::CommonMethods
        end
        module ClassMethods
        end
        module InstanceMethods
          def custom_captcha(options={})
            return "" unless (@object.custom_captcha_key rescue nil)
            options[:object_name] = @object_name.to_s
            options[:key] = @object.custom_captcha_key

            options[:field_name] = object_field_name options[:object_name], CustomCaptcha::DEFAULTVALUE[:field_name]
            options[:key_name] = object_field_name options[:object_name], CustomCaptcha::DEFAULTVALUE[:key_name]
            options[:key_id] = object_field_id options[:object_name], CustomCaptcha::DEFAULTVALUE[:key_id]
            options[:img_id] = object_field_id options[:object_name], CustomCaptcha::DEFAULTVALUE[:img_id]

            @template.display_custom_captcha(options)
          end
        end
      end
    end
  end
end


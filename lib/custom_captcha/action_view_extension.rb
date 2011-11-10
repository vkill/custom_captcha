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
          if options[:object_name]
            options[:custom_captcha_name] ||= object_field_tag_name options[:object_name], 'custom_captcha'
            options[:custom_captcha_image_file_key_name] =
                      object_field_tag_name options[:object_name], 'custom_captcha_image_file_key'
            options[:custom_captcha_image_file_key_id] ||=
                      object_field_tag_id options[:object_name], 'custom_captcha_image_file_key'
            options[:img_tag_id] ||= object_field_tag_id options[:object_name], 'custom_captcha_img_tag'
          else
            options[:custom_captcha_name] ||= 'custom_captcha'
            options[:custom_captcha_image_file_key_name] = 'custom_captcha_image_file_key'
            options[:custom_captcha_image_file_key_id] ||= 'custom_captcha_image_file_key'
            options[:img_tag_id] ||= 'custom_captcha_img_tag'
            options[:custom_captcha_image_file_key] = CustomCaptcha::Utils.choice_image_file_key_by_rand()
          end
          set_captcha_session CustomCaptcha::Utils.generate_captcha_digested(options[:custom_captcha_image_file_key])
          options[:img_tag_src] = show_captcha_image_path(options[:custom_captcha_image_file_key])
          options[:template] ||= 'default'
          options[:label_name] ||= I18n.t('custom_captcha.label')
          options[:change_text] ||= I18n.t('custom_captcha.change')
          options[:change_url] = change_captcha_images_path(:img_tag_id => options[:img_tag_id],
                                              :image_file_key_tag_id => options[:custom_captcha_image_file_key_id])
          render "custom_captcha/captcha_styles/#{options[:template]}", :captcha => options
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
            return "" unless (@object.custom_captcha_image_file_key rescue nil)
            options[:object_name] = @object_name.to_s
            options[:custom_captcha_image_file_key] = @object.custom_captcha_image_file_key
            @template.display_custom_captcha(options)
          end
        end
      end
    end
  end
end


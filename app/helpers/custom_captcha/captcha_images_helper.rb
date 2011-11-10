module CustomCaptcha::CaptchaImagesHelper

  def display_custom_captcha(options={})
    options[:template] ||= 'default'
    options[:label_name] ||= I18n.t('custom_captcha.label')
    options[:input_name] ||= 'captcha'
    options[:img_tag_id] ||= 'custom_captcha'
    options[:change_text] ||= I18n.t('custom_captcha.change')
    options[:image_file_key] = CustomCaptcha::Utils.choice_image_file_key_by_rand()
    session[:captcha_digested] = CustomCaptcha::Utils.generate_captcha_digested(options[:image_file_key])
    render "custom_captcha/captcha_styles/#{options[:template]}", :captcha => options
  end

end


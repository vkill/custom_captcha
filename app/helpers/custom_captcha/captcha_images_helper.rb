module CustomCaptcha::CaptchaImagesHelper

  def display_custom_captcha(template="default")
    @captcha = {}
    @captcha[:image_file_key] = CustomCaptcha::Utils.choice_image_file_key_by_rand()
    session[:captcha_digested] = CustomCaptcha::Utils.generate_captcha_digested(@captcha[:image_file_key])
    render "custom_captcha/captcha_styles/#{template}", :captcha => @captcha
  end

end


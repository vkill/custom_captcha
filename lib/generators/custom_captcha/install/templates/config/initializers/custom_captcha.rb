CustomCaptcha.configure do |config|
  config.image_columns  = 120
  config.image_rows     = 40
  config.image_style    = "simply_blue"
  config.text_range     = ("a".."z").to_a
  config.text_length    = 5
  config.images_path    = Rails.join("public", "system", "captcha")
  config.enable         = true
end


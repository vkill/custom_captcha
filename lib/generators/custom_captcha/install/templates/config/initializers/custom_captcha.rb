CustomCaptcha.configure do |config|
  config.image_columns  = 120
  config.image_rows     = 40
  config.image_style    = "simply_blue"
  config.text_range     = ("a".."z").to_a
  config.text_length    = 5
  config.images_path    = Rails.root.join("public", "system", "captcha_images").to_s
  config.enable         = true
  config.salt           = "<%= SecureRandom.hex(20) %>"
end


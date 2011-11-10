class CustomCaptcha::CaptchaImagesController < ApplicationController

  respond_to :html, :js, :json

  def show
    @image_file = CustomCaptcha::Utils.get_image_file_path_by_key(params[:key])
    respond_to do |format|
      format.html {
        send_file(@image_file, :type => 'image/jpeg', :disposition => 'inline', :filename => 'custom_captcha.jpg')
      }
      format.json { render :json => {:image_file => @image_file} }
    end
  end

  def change
    @image_file_key = CustomCaptcha::Utils.choice_image_file_key_by_rand()
    set_captcha_session CustomCaptcha::Utils.generate_captcha_digested(@image_file_key)
    @img_tag_src = show_captcha_image_path(@image_file_key)
    @img_tag_id = params[:img_tag_id] || "custom_captcha_img_tag"
    @image_file_key_tag_id = params[:image_file_key_tag_id] || "custom_captcha_image_file_key"
    respond_to do |format|
      format.html { redirect_to @captcha[:image_url] }
      format.js #change.js.erb
      format.json { render :json => {@img_tag_id => @img_tag_src, @image_file_key_tag_id => @image_file_key} }
    end
  end

end


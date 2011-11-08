class CustomCaptcha::CaptchaImagesController < ApplicationController

  respond_to :html, :js, :json

  def show
    @image_file = CustomCaptcha::Utils.get_image_file_path_by_key(params[:key])
    respond_to do |format|
      format.html {
        if @image_file.blank?
          # if user forged address, redirect to '/change' and generate new session, then re-redirect to "/show"
          redirect_to change_captcha_images_path
        else
          send_file(@image_file, :type => 'image/jpeg', :disposition => 'inline', :filename => 'custom_captcha.jpg')
        end
      }
      format.json {
        render :json => {:image_file => @image_file}
      }
    end
  end

  def change
    @captcha = {}
    @captcha[:image_file_key] = CustomCaptcha::Utils.choice_image_file_key_by_rand()
    session[:captcha_digested] = CustomCaptcha::Utils.generate_captcha_digested(@captcha[:image_file_key])
    @captcha[:image_url] = show_captcha_image_path(@captcha[:image_file_key])
    @img_tag_id = params[:img_tag_id] || "custom_captcha"
    respond_to do |format|
      format.html { redirect_to @captcha[:image_url] }
      format.js #change.js.erb
      format.json { render :json => { :image_url => @captcha[:image_url]}}
    end
  end

end


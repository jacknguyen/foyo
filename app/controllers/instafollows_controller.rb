class InstafollowsController < ApplicationController
  def index
    if !params[:url].nil? && !params[:url].empty?
      @image_id = Picture.image_id(params[:url])
      @instagram_image = Instagram.media_item(@image_id)
    else
      render 'index'
    end
  end

  def show

  end

  # sends user to authorize the app and get back the access token
  # CALLBACK_URL is set in the instagram.rb initializer file
  def oauth
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end

  # once the user accepts then instagram will redirect back to this url
  # the callback url is set on the developer api setting
  # https://instagram.com/developer/clients/manage/
  # set the url to "#{site_url}/oauth/callback"
  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect_to root_url
  end

  # for the following two actions to work you must request access to set
  # relationship through instagram using their form
  # https://instagram.com/developer/endpoints/relationships/
  # Current rate limit of 60/hour for authenticated users
  def follow
    begin
      user_id = params[:id]
      response = Instagram.follow_user(user_id)
      redirect_to root_url
    rescue response
      redirect_to root_url
    end
  end

  def unfollow
    user_id = params[:id]
    response = Instagram.unfollow_user(user_id)

    redirect_to root_url
  end

  private
    def search_params
      Params.permit(:url)
    end
end

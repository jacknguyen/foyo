require 'instagram'

# Set callback url to site url but keep the path
if ENV['RAILS_ENV'] == 'development'
  CALLBACK_URL = "http://localhost:3000/oauth/callback"
else
  CALLBACK_URL = "https://foyo.herokuapp.com//oauth/callback"
end

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_ID']
  config.client_secret = ENV['INSTAGRAM_SECRET']
end

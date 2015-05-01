require 'open-uri'

class Picture < ActiveRecord::Base

  def self.request_image_data_from_instagram(image_url)
    instagram_api_url = "http://api.instagram.com/oembed?url="
    full_url = instagram_api_url + image_url.to_s
    open(full_url).read
  end

  def self.parse_response_to_json(response)
    JSON.parse(response)
  end

  def self.image_id(image_url)
    response = request_image_data_from_instagram(image_url)
    image_json = parse_response_to_json(response)
    image_json['media_id']
  end
end
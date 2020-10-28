require 'rest-client'
require 'json'

class GetGoogleCoffeeListService
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def call
    google_url = 'https://maps.googleapis.com/maps/api/place/textsearch/'
    location = "#{@latitude},#{@longitude}"
    radius = '5000'
    key = Rails.application.credentials.google_secret_key
    base_url = "#{google_url}json?query=cafe&location=#{location}&radius=#{radius}&key=#{key}"
    response = RestClient.get base_url
    JSON.parse(response.body)
  rescue RestClient::ExceptionWithResponse => e
    e.response
  end
end

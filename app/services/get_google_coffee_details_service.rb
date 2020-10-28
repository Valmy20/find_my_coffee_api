require 'rest-client'
require 'json'

class GetGoogleCoffeeDetailsService
  def initialize(google_place_id)
    @google_place_id = google_place_id
  end

  def call
    google_url = 'https://maps.googleapis.com/maps/api/place/details/'
    key = Rails.application.credentials.google_secret_key
    base_url = "#{google_url}json?place_id=#{@google_place_id}&key=#{key}"
    response = RestClient.get base_url
    JSON.parse(response.body)
  rescue RestClient::ExceptionWithResponse => e
    e.response
  end
end

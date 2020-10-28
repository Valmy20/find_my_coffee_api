class Store < ApplicationRecord
  has_many :ratings
  validates_presence_of :lonlat, :name, :google_place_id
  validates :google_place_id, uniqueness: true

  scope :within, lambda { |longitude, latitude, distance_in_km = 5|
    where(format(%{
      ST_Distance(lonlat, 'POINT(%f %f)') < %d
    }, longitude, latitude, distance_in_km * 1000))
  }

  def ratings_average
    return 0 if ratings.empty?

    (ratings.sum(:value) / ratings.count).to_i
  end
end

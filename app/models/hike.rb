class Hike < ApplicationRecord
  # database relationships:
  has_many :trackpoints
  has_many :waypoints
  has_many :points

  # validations
  validates :name,
  presence: true
  validates :start_lat,
  presence: true
  validates :start_lng,
  presence: true


  # method to return all the hikes that are within the boundaries of the map displayed on the react front end of the app
  # min_lat, ect are passed in from the front end to the hikes controller
  def self.search(min_lat:, max_lat:, min_lng:, max_lng:)
    results = Hike.limit(100).where(start_lng: min_lng...max_lng, start_lat: min_lat...max_lat)
    # binding.pry
    return results
  end
end

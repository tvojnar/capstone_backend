class Waypoint < ApplicationRecord
  belongs_to :hike

  validates :lng, presence: true
  validates :lat, presence: true 
end

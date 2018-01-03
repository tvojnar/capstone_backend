class Trackpoint < ApplicationRecord
  belongs_to :hike

  validates :lat, presence: true
  validates :lng, presence: true 
end

class Hike < ApplicationRecord
  has_many :trackpoints
  has_many :waypoints
  has_many :points

  validates :name,
          presence: true,
          uniqueness: true

  validates :start_lat,
            presence: true

  validates :start_lng,
            presence: true
end

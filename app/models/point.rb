class Point < ApplicationRecord
  belongs_to :hike
  has_many :photos

  validates :lng, presence: true
  validates :lat, presence: true 
end

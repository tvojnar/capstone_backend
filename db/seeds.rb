# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# center_point = { lat: 50.0515918, lng: 19.9357531 }
#
# 1.upto(1000) do |i|
#   Place.create!(
#     name: Faker::Address.city,
#     description: Faker::Lorem.paragraph(8),
#     longitude: center_point[:lng] + rand(-10.00..10.00),
#     latitude: center_point[:lat] + rand(-10.00..10.00),
#     price: rand(1..500)
#   )
# end

Hike.create!(
  name: 'Lake 22',
  start_lat: 48.0770,
  start_lng: -121.7457,
  region: 'North Cascades',
  description: 'Hike through lush forrest with many waterfalls to a mountain lake',
  notes: 'Good spot to swim at about 1 O\'Clock on the lake',
  start_date: Date.today,
  end_date: Date.today,
  num_days: 1,
  miles: 5.4,
  elevation_gain: 1350,
  max_elevation: 2400,
  lakes: true,
  waterfalls: true,
  old_growth: true,
  day_hike: true
)


Hike.create!(
  name: 'Shriner Peak',
  start_lat: 46.8018,
  start_lng: -121.5551,
  region: 'Mount Rainier',
  description: 'Steep hike with amazing views of Mt. Rainier',
  notes: 'More shade over the trail then discribed on the wta site',
  start_date: Date.new(2017, 6, 24),
  end_date: Date.new(2017, 6, 24),
  num_days: 1,
  miles: 8.5,
  elevation_gain: 3434,
  max_elevation: 5834,
  day_hike: true,
  wildflowers: true,
  mountain_views: true,
  summits: true
)

Hike.create!(
  name: 'Surprise and Glacier Lakes',
  start_lat: 47.7078,
  start_lng: -121.1567,
  region: 'Central Cascades',
  description: 'Two lakes set between peaks',
  notes: 'Go later in the summer and try to see the Thunder lakes as well',
  start_date: Date.new(2017, 7, 24),
  end_date: Date.new(2017, 7, 26),
  num_days: 3,
  miles: 11.0,
  elevation_gain: 2700,
  max_elevation: 4900,
  overnight: true,
  wildflowers: true,
  mountain_views: true,
  summits: true,
  lakes: true
)

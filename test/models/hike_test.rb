require "test_helper"

describe Hike do
  let :hike {Hike.create(name: 'test hike', start_lat: 47.6062, start_lng: 122.3321)}

  describe 'relationships' do
    it 'has many trackpoints' do
      hike.must_respond_to :trackpoints
      hike.trackpoints.must_be_empty

      # Use create! so that it will complain loudly if something is off with Trackpoint
      trp = Trackpoint.create!(hike_id: hike.id, lat: 46.6062, lng: 123.3321, elevation: 500)

      hike.trackpoints.must_include trp
    end # many trackpoints

    it 'has many waypoints' do
      hike.must_respond_to :waypoints
      hike.waypoints.must_be_empty

      w = Waypoint.create!(hike_id: hike.id, lat: 46.6062, lng: 123.3321 )

      hike.waypoints.must_include w
    end # many waypoints

    it 'has many points' do
      hike.must_respond_to :points
      hike.points.must_be_empty

      point = Point.create!(hike_id: hike.id, lat: 46.6062, lng: 123.3321)

      hike.points.must_include point
    end # many waypoints
  end # relationships

  describe "validations" do

    it 'requires a name' do
      # create an invalid instance of hike
      hike_2 = Hike.new(start_lat: 47.6062, start_lng: 122.3321)

      # check that it is invalid
      is_valid = hike_2.valid?
      is_valid.must_equal false
      hike_2.errors.messages.must_include :name
    end # requires a name

    it 'requires a unique name' do
      # create a valid instance of hike
      hike_1 = Hike.create!(name: 'same name', start_lat: 47.6062, start_lng: 122.3321)
      # create an invalid instance (which has the same name as hike_1)
      hike_2 = Hike.new(name: 'same name', start_lat: 47.6062, start_lng: 122.3321)

      # check that it is invalid
      is_valid = hike_2.valid?
      is_valid.must_equal false
      hike_2.errors.messages.must_include :name
    end # unique name

    it 'requires a starting latitude' do
      bad_hike = Hike.new(name: 'test hike', start_lng: 122.3321)

      is_valid = bad_hike.valid?
      is_valid.must_equal false
      bad_hike.errors.messages.must_include :start_lat
    end # requites a latitude

    it 'requires a longitude' do
      bad_hike = Hike.new(name: 'test hike', start_lat: 47.6062)

      is_valid = bad_hike.valid?
      is_valid.must_equal false
      bad_hike.errors.messages.must_include :start_lng

    end # requites a longitude

    it 'can create a valid instance of hike' do
      good_hike = Hike.new(name: 'test hike', start_lat: 47.6062, start_lng: 122.3321)

      is_valid = good_hike.valid?
      is_valid.must_equal true
    end
  end # valdidations

end

require "test_helper"

describe Waypoint do
  let :hike {Hike.create(name: 'test hike', start_lat: 47.6062, start_lng: 122.3321)}
  describe 'relationships' do
    it 'belongs to a hike' do
      w = Waypoint.new(hike_id: hike.id, lat: 47.6062, lng: 122.3321)
      w.must_respond_to :hike
      w.hike.must_equal hike
      w.hike_id.must_equal hike.id
    end # belongs to a hike
  end # relationships

  describe 'validations' do
    it 'requires a lng' do
      bad_wp = Waypoint.new(hike_id: hike.id, lat: 123.3321)

      is_valid = bad_wp.valid?
      is_valid.must_equal false
      bad_wp.errors.messages.must_include :lng
    end # a lng

    it 'requires a lat' do
      bad_wp = Waypoint.new(hike_id: hike.id, lng: 123.3321)

      is_valid = bad_wp.valid?
      is_valid.must_equal false
      bad_wp.errors.messages.must_include :lat
    end # a lat
  end
end

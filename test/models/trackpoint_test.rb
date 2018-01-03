require "test_helper"

describe Trackpoint do
  let :hike {Hike.create(name: 'test hike', start_lat: 47.6062, start_lng: 122.3321)}
  describe 'relationships' do
    it 'belongs to a hike' do
      trp = Trackpoint.new(hike_id: hike.id, lat: 46.6062, lng: 123.3321, elevation: 500)
      trp.must_respond_to :hike
      trp.hike.must_equal hike
      trp.hike_id.must_equal hike.id
    end # belongs to a hike
  end # relationships

  describe 'validations' do
    it 'requires a lat' do
      bad_trp = Trackpoint.new(hike_id: hike.id, lng: 123.3321, elevation: 500)

      is_valid = bad_trp.valid?
      is_valid.must_equal false
      bad_trp.errors.messages.must_include :lat

    end # a lat

    it 'requires a lng' do
      bad_trp = Trackpoint.new(hike_id: hike.id, lat: 123.3321, elevation: 500)

      is_valid = bad_trp.valid?
      is_valid.must_equal false
      bad_trp.errors.messages.must_include :lng

    end # a lng
  end
end # Trackpoint

require "test_helper"

describe Point do
  let :hike {Hike.create(name: 'test hike', start_lat: 47.6062, start_lng: 122.3321)}

  let :point {Point.create(hike_id: hike.id, lat: 46.6062, lng: 123.3321)}
  describe 'relationships' do
    it 'belongs to a hike' do
      point.must_respond_to :hike
      point.hike.must_equal hike
      point.hike_id.must_equal hike.id
    end # belongs to a hike

    it 'has many photos' do
      point.must_respond_to :photos
      point.photos.must_be_empty

      photo = Photo.create!(point_id: point.id)

      point.photos.must_include photo
    end # many photos
  end # relationships

  describe 'validations' do
    it 'requires a lng' do
      bad_point = Point.new(hike_id: hike.id, lat: 46.6062)

      is_valid = bad_point.valid?
      is_valid.must_equal false
      bad_point.errors.messages.must_include :lng
    end # a lng

    it 'requires a lat' do
      bad_point = Point.new(hike_id: hike.id, lng: 46.6062)

      is_valid = bad_point.valid?
      is_valid.must_equal false
      bad_point.errors.messages.must_include :lat
    end # a lat
  end # validations
end

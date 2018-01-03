require "test_helper"

describe Photo do
  let :hike {Hike.create(name: 'test hike', start_lat: 47.6062, start_lng: 122.3321)}

  let :point {Point.create(hike_id: hike.id, lat: 46.6062, lng: 123.3321)}

  describe 'relationships' do
    it 'belongs to a point' do
      photo = Photo.new(point_id: point.id)
      photo.must_respond_to :point
      photo.point.must_equal point
      photo.point_id.must_equal point.id
    end # belongs to a hike
  end # relationships
end

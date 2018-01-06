require "test_helper"
require 'pry-rails'

describe HikesController do
  describe "index" do
    it 'has a working rout' do
      # make api request, passing in the min and max lat and lng
      get hikes_path(min_lat: 47.0, max_lat: 49.0, min_lng: -125.0, max_lng: -120.0)
      # the api call must be a success
      must_respond_with :success
    end # working rout

    it 'returns json' do
      get hikes_path(min_lat: 47.0, max_lat: 49.0, min_lng: -125.0, max_lng: -120.0)
      response.header['Content-Type'].must_include 'json'
    end # returns json

    it 'returns an empty array when there are no movies array' do
      # remove all the hikes
      Hike.destroy_all

      # make the api call
      get hikes_path(min_lat: 47.0, max_lat: 49.0, min_lng: -125.0, max_lng: -120.0)

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end # returns an empty array

    it 'returns an array containing hikes' do
      # TODO: figure out why it isn't returning a hike

      # create a hike that is within the min/max bounds of the get request
      hike = Hike.create(name: 'test', start_lat: 48.0, start_lng: -122.0)

      hike_2 = Hike.create(name: 'test 2', start_lat: 48.6, start_lng: -123.0)


      # make the get request to the index action
      get hikes_path(min_lat: 47.0, max_lat: 49.0, min_lng: -125.0, max_lng: -120.0)

      # parse the response
      # make sure that the response includes one hike
      must_respond_with :success
      body = JSON.parse(response.body)
      body.length.must_be :>, 0

      # it will return the name, start_lat, and start_lng for each Hikes
      body.each do |hike|
        hike.keys.must_include 'name'
        hike.keys.must_include 'start_lat'
        hike.keys.must_include 'start_lng'
      end # .each
    end # returns an array containing a hike

    it 'wont include a hike that is outside of the lat/lng boundaries' do
      # destroy all the hikes
      Hike.destroy_all

      # create a hike that is outside the min/max bounds of the get request
      hike = Hike.create(name: 'test', start_lat: 55.0, start_lng: -155.0)

      # make the get request to the index action
      get hikes_path(min_lat: 47.0, max_lat: 49.0, min_lng: -125.0, max_lng: -120.0)

      # verify that no
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end # won't return hike that is outside of the boundaries
  end # index


  describe 'create' do
    let(:hike_data) {
      {
        name: 'Fake hike',
        start_lat: 48.6,
        start_lng: -123,
        region: 'Central Washington',
        description: 'A great fake hike',
      }
    } # let

    it 'creates a hike' do
      # make a post request
      proc {
        post hikes_path, params: {hike: hike_data}
      }.must_change 'Hike.count', 1

      # assert that the post request was successful
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "name"
      Hike.find(body["id"]).name.must_equal hike_data[:name]
    end # creates a hike

    it 'wont change the db if data is missing' do
      # create invalid data to pass as params (missing start_lat)
      invalid_hike_data = {
          name: 'Fake hike',
          start_lng: -123,
        }

      # make a post request with the invalid data
      proc {
        post hikes_path, params: {hike: invalid_hike_data}
      }.wont_change 'Hike.count'

      # verify that the post request failed because the start_lat was missing
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_equal "errors" => {"start_lat" => ["can't be blank"] }
    end # won't change db if data is missing

    
  end # create
end

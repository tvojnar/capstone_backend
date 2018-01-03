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

    it 'returns a hike' do
      # TODO: figure out why it isn't returning a hike

      # create a hike that is within the min/max bounds of the get request
      hike = Hike.create(name: 'test', start_lat: 48.0, start_lng: -122.0)

      # make the get request to the index action
      get hikes_path(min_lat: 47.0, max_lat: 49.0, min_lng: -125.0, max_lng: -120.0)

      # parse the response
      # make sure that the response includes one hike
      must_respond_with :success
      body = JSON.parse(response.body)
      binding.pry
      body.length.must_be :>, 0

    end # returns an array
  end # index
end

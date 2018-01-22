require "test_helper"
require 'pry-rails'

describe HikesController do
  # create valid hike data to use in the tests
  let(:hike_data) {
    {
      name: 'Fake hike',
      start_lat: 48.6,
      start_lng: -123,
      region: 'Central Washington',
      description: 'A great fake hike',
      image_url: 'a_test_url',
    }
  } # let

  # create invalid data to pass as params (missing start_lat)
  let(:invalid_hike_data) {
    {
      name: 'Invalid hike',
      start_lng: -123,
    }
  } # let

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


  describe 'show' do
    it 'can get a hike' do
      # ACTION
      # make a GET request to the show action to get the details for that hike
      get hike_path(hikes(:one).id)

      # ASSERT
      # confirm that the GET request was a success
      must_respond_with :success
      # confirm that the correct hike's data was retuned
      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      Hike.find(body["hike_data"]["id"]).name.must_equal hikes(:one).name
      # confirm that all the nessessary data was returned
      attributes = ['id',
        'name',
         'start_lat', 'start_lng', 'region', 'start_date', 'end_date', 'max_elevation', 'elevation_gain', 'description', 'notes', 'lakes', 'coast', 'rivers', 'waterfalls', 'fall_foliage', 'wildflowers', 'meadows', 'old_growth', 'mountain_views', 'summits', 'established_campsites', 'day_hike', 'overnight']
      attributes.each do |attribute|
        body["hike_data"].must_include attribute
      end # .each
    end # returns a hike

    it 'behaves correctly when the hike does not exist' do
      invalid_hike_id = Hike.all.last.id + 1
      get hike_path(invalid_hike_id)

      must_respond_with :not_found

      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end  # when the hike does not exist
  end # show


  describe 'create' do


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
      Hike.find(body["id"]).image_url.must_equal hike_data[:image_url]
    end # creates a hike

    it 'wont change the db if data is missing' do

      # make a post request with the invalid data
      proc {
        post hikes_path, params: {hike: invalid_hike_data}
      }.wont_change 'Hike.count'

      # verify that the post request failed because the start_lat was missing
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_equal "errors" => {"start_lat" => ["can't be blank", "is not a number"] }
    end # won't change db if data is missing
  end # create

  describe 'update' do
    let(:new_hike_data) {
      {
        name: 'New Name',
        start_lat: 60,
        start_lng: -160,
        region: 'Mount Rainier Area',
        description: 'A new discription for the hike',
        lakes: true,
        image_url: "test_url_for_image"
      }
    } # let

    it 'will update the attributes of a hike' do
      # make a post request to create a hike
      proc {
        post hikes_path, params: {hike: hike_data}
      }.must_change 'Hike.count', 1

      # assert that the post request was successful
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_include "id"
      Hike.find(body["id"]).name.must_equal hike_data[:name]

      # pull out the hikes id
      hikeId = body["id"]

      # make a patch request to update the hike
      patch hike_path(hikeId), params: {hike: new_hike_data}

      # assert that the patch was a success
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_include "id"
      body.must_include "name"


      # assert that changes were made to the hikes
      Hike.find(body["id"]).name.must_equal new_hike_data[:name]
      Hike.find(body["id"]).start_lat.must_equal new_hike_data[:start_lat]
      Hike.find(body["id"]).start_lng.must_equal new_hike_data[:start_lng]
      Hike.find(body["id"]).region.must_equal new_hike_data[:region]
      Hike.find(body["id"]).description.must_equal new_hike_data[:description]
      Hike.find(body["id"]).lakes.must_equal new_hike_data[:lakes]
      Hike.find(body["id"]).coast.must_equal new_hike_data[:coast]
      Hike.find(body["id"]).image_url.must_equal new_hike_data[:image_url]

    end # will update the hike's attributes

    it 'will not update the hike if the data passed in the params is bad' do
      bad_data = {
        name: 'New Name',
        start_lat: 'string',
        start_lng: -123,
      }
      # make a post request to create a hike
      proc {
        post hikes_path, params: {hike: hike_data}
      }.must_change 'Hike.count', 1

      # assert that the post request was successful
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_include "id"
      Hike.find(body["id"]).name.must_equal hike_data[:name]

      # pull out the hikes id
      hikeId = body["id"]

      # make a patch request to update the hike
      patch hike_path(hikeId), params: {hike: bad_data}

      # assert that the patch request failed
      # verify that the post request failed because the start_lat was missing
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_equal "errors" => {"start_lat" => ["is not a number"] }
    end # wont update with bad data

    it 'will not update the hike if the data passed in the params has a blank name' do
      bad_data = {
        name: '',
        start_lat: 47,
        start_lng: -123,
      }
      # make a post request to create a hike
      proc {
        post hikes_path, params: {hike: hike_data}
      }.must_change 'Hike.count', 1

      # assert that the post request was successful
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_include "id"
      Hike.find(body["id"]).name.must_equal hike_data[:name]

      # pull out the hikes id
      hikeId = body["id"]

      # make a patch request to update the hike
      patch hike_path(hikeId), params: {hike: bad_data}

      # assert that the patch request failed
      # verify that the post request failed because the start_lat was missing
      must_respond_with :bad_request
      body = JSON.parse(response.body)
      body.must_equal "errors" => {"name" => ["can't be blank"] }
    end # wont update with bad data]
  end # update


  describe 'destroy' do
    it "will destroy a hike and all of it's trackpoint if it exists" do
      # ARANGE
      # pull out a hike to delete
      hike = hikes(:one);
      # create two trackpoints for that hike
      trkpt = Trackpoint.create!(hike_id: hike.id, lat: 45, lng: -123)
      trkpt2 = Trackpoint.create!(hike_id: hike.id, lat: 46, lng: -123)

      # establish the number of trackpoints 'hike' has as well as the total number of trackpoints in the db
      hike_trkpt = hike.trackpoints.count
      num_trkpts = Trackpoint.count

      #ACT
      # delete 'hike'
      # make sure that the number of Hikes decreases by 1
      proc {
        delete hike_path(hike.id)
      }.must_change 'Hike.count', -1

      # ASSERT
      # make sure that the controller action responds with success
      must_respond_with :success

      # make sure that all of 'hikes' trackpoints were also deleted
      Trackpoint.count.must_equal num_trkpts - hike_trkpt
    end # distroys hike

    it "won't destroy the hike if it does not exist" do
      # ARANGE
      # get a a hike id that does not exist
      hike_id = Hike.last.id + 1


      #ACT
      # try to delete the nonexistant hike
      # make sure that the number of Hikes does not change
      proc {
        delete hike_path(hike_id)
      }.wont_change 'Hike.count'

      # ASSERT
      # make sure that the controller action responds with bad_request
      must_respond_with :bad_request
    end # won't distroy if not existant



  end # destroy
end

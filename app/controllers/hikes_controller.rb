

class HikesController < ApplicationController
  # protect_from_forgery with: :null_session

  def index
    hikes = Hike.search(search_params.to_h.symbolize_keys)
    # binding.pry
    # The api call is being made and I can see when I do binding.pry that there are hikes being returned, but I don't see those hikes yet in the api response, so I need to figure out why the API isn't sending the hike data to the front end
    render json: hikes
  end # index

  def show
    # find the hike using the id params passed from the frontend
    hike = Hike.find_by(id: params[:id])


    # if the hike exists then always send the hike's attributes back to the user as the value of the hike_data key
    if hike
      # get all the trackpoints that are associated with that hike
      hike_trackpoints = hike.trackpoints

      # create an empty array to store the lat and lng array for each trackpoint
      trackpoint_array = []

      # make an hash that is {lat: lat_value, lng: lng_value} for each trackpoint and push the array into the trackpoint_array
      hike_trackpoints.each do |tp|
        tp_array = {lat: tp.lat, lng: tp.lng}
        trackpoint_array << tp_array
      end # .each

        # if the hike has trackpoints associated with it then also send the trackpoint_array to the user as the value for the trackpoints key
      if trackpoint_array.length > 0

        render(
          json: {hike_data: hike.as_json(except: [:created_at, :updated_at]), trackpoints: trackpoint_array }, status: :ok
        )
      elsif trackpoint_array.length <= 0
        render(
          json: {hike_data: hike.as_json(except: [:created_at, :updated_at])}, status: :ok
        )
      end # inner if
      # if the hike does not exist then send a not_found status to the user
    else
      render(
        json: {nothing: true}, status: :not_found
      )
    end # outer if/else
  end # show

  def create
    hike = Hike.new(hike_params)

    if hike.save
      render(
        json: {id: hike.id, name: hike.name}, status: :ok
      )
    else
      render(
        json: {errors: hike.errors.messages}, status: :bad_request
      )
    end # if/else

    # NOTE: use to test fake api post before I figure out how to pass the right data
    # render(
    #   json: {post: 'worked'}, status: :ok
    # )
  end # create

  def update
    # find the hike to update
    hike = Hike.find(params[:id])

    # update the attributes based on the params sent from the client
    hike.update_attributes(hike_params)

    # render difference json depending on if the update was sucessful or not
    if hike.save
      render(
        json: {id: hike.id, name: hike.name}, status: :ok
      )
    else
      render(
        json: {errors: hike.errors.messages}, status: :bad_request
      )
    end
  end # update

  def destroy
    hike = Hike.find_by(id: params[:id])
    if hike
      hike.destroy
      render(
        json: {message: 'Hike deleted', id: hike.id}, status: :ok
      )
    else
      render(
        json: {error: 'Hike does not exist'}, status: :bad_request
      )
    end # if/else what to render
  end # destroy

  private

  def search_params
    params.permit(:min_lng, :max_lng, :min_lat, :max_lat)
  end

  def hike_params
    params.require(:hike).permit(:image_url, :id, :name, :start_lat, :start_lng, :region, :description, :notes, :start_date, :end_date, :miles, :elevation_gain, :max_elevation, :coast, :rivers, :lakes, :waterfalls, :fall_foliage, :wildflowers, :meadows, :mountain_views, :summits, :established_campsites, :day_hike, :overnight, :old_growth)
  end # hike_params
end

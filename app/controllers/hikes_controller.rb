

class HikesController < ApplicationController
  # protect_from_forgery with: :null_session

  def index
    hikes = Hike.search(search_params.to_h.symbolize_keys)
    # binding.pry
    # The api call is being made and I can see when I do binding.pry that there are hikes being returned, but I don't see those hikes yet in the api response, so I need to figure out why the API isn't sending the hike data to the front end
    render json: hikes
  end # index

  def show
    hike = Hike.find_by(id: params[:id])

    if hike
      render(
        json: {hike_data: hike.as_json(except: [:created_at, :updated_at])}, status: :ok
      )
    else
      render(
        json: {nothing: true}, status: :not_found
      )
    end # if/else
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

  private

  def search_params
    params.permit(:min_lng, :max_lng, :min_lat, :max_lat)
  end

  def hike_params
    params.require(:hike).permit(:image_url, :id, :name, :start_lat, :start_lng, :region, :description, :notes, :start_date, :end_date, :miles, :elevation_gain, :max_elevation, :coast, :rivers, :lakes, :waterfalls, :fall_foliage, :wildflowers, :meadows, :mountain_views, :summits, :established_campsites, :day_hike, :overnight, :old_growth)
  end # hike_params
end

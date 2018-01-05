require 'pry-rails'

class HikesController < ApplicationController
  def index
    hikes = Hike.search(search_params.to_h.symbolize_keys)
    # binding.pry
    # The api call is being made and I can see when I do binding.pry that there are hikes being returned, but I don't see those hikes yet in the api response, so I need to figure out why the API isn't sending the hike data to the front end
    render json: hikes
  end # index

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
  end # create

  private

  def search_params
    params.permit(:min_lng, :max_lng, :min_lat, :max_lat)
  end
end


class TrackpointsController < ApplicationController
  def create
    # binding.pry
    # puts "******************"
    # puts params
    # # puts params[:gpx_file]
    # puts "&&&&&&&&&&&&&&&&&&&&"

    # pull out the hike_id the trackpoints are for from the url params
    id_of_hike = params[:hike_id]
    # start off by deleting all old trackpoints for this hike so that there is a new track uploaded
    Trackpoint.where(hike_id: id_of_hike).destroy_all

    # get all of the trackpoints (which have lat and lng as attributes) out of the xml that was sent via params from the ajax POST on the frontend
    doc = Nokogiri::XML(trackpoint_params)
    points = doc.search('trkpt')

    # start off with an id of 0 to set for the trackpoint_number
    id_for_trkpt = 0

    # create a new trackpoint for each trkpt in points
    points.each do |pt|
      trackpoint = Trackpoint.new(trackpoint_num: id_for_trkpt, lat: pt.attr("lat"), lng: pt.attr('lon'), hike_id: id_of_hike)
      trackpoint.save
      puts trackpoint
      puts trackpoint.errors.full_messages
      id_for_trkpt += 1
    end # .each

    # trackpoints = doc.xpath('//xmlns:trkpt/')
    # points = Array.new
    # trackpoints.each do |trkpt|
    #   points << [trkpt.xpath('@lat').to_s.to_f, trkpt.xpath('@lon').to_s.to_f]
    # end
    # render(
    #   json: {trackpoints: points}
    # )
    #Hike.find_by(id: 90).trackpoints

    # with zac
    # doc = Nokogiri::XML(trackpoint_params)
    # points = doc.search('trkpt')
    # will output all of the lats
    # points.each { |pt| puts pt.attr("lat") }
    # will output all of the lats and lngs
    # points.each { |pt| puts " #{pt.attr('lat')}, #{pt.attr('lon')} " }
    num_trkpt = Trackpoint.count
    render(
      json: {worked: 'yes', trackpoint_num: num_trkpt}
    )
  end # create

  private

  def trackpoint_params
      params.keys[0] + params[params.keys[0]]
  end # trackpoint_params
end

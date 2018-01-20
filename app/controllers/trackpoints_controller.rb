
class TrackpointsController < ApplicationController
  def create
    binding.pry
    puts "******************"
    puts params
    # puts params[:gpx_file]
    puts "&&&&&&&&&&&&&&&&&&&&"
    doc = Nokogiri::XML(trackpoint_params)
    # trackpoints = doc.xpath('//xmlns:trkpt/')
    # points = Array.new
    # trackpoints.each do |trkpt|
    #   points << [trkpt.xpath('@lat').to_s.to_f, trkpt.xpath('@lon').to_s.to_f]
    # end
    # render(
    #   json: {trackpoints: points}
    # )

    # with zac
    # doc = Nokogiri::XML(trackpoint_params)
    # points = doc.search('trkpt')
    # will output all of the lats
    # points.each { |pt| puts pt.attr("lat") }
    # will output all of the lats and lngs
    # points.each { |pt| puts " #{pt.attr('lat')}, #{pt.attr('lon')} " }

    render(
      json: {worked: 'yes'}
    )

  end # create

  private

  def trackpoint_params
      params.keys[0] + params[params.keys[0]]
  end # trackpoint_params
end

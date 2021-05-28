require_relative '../../db/spot_scrape'

class SpotsController < ApplicationController
  def index
    if params[:query].present?
      @spots = Spot.near(params[:query], 400)
    else
      @spots = Spot.all
    end

    @markers = @spots.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude
      }
    end
    @user_spots = current_user.user_spots
  end

  def show
    @spot = Spot.find(params[:id])
    @markers =
      [{
        lat: @spot.latitude,
        lng: @spot.longitude
      }]
  end

  def new
    @spot = Spot.new
  end

  def create
    url_spot_id = scrap_surfline_spot_id(location_human_to_query(params[:spot][:name]))
    spot_id = get_id_location(url_spot_id)
    @spot = Spot.new(name: params[:spot][:name])
    @spot.surfline_spot = spot_id

    wind_json = call_wind_api(spot_id)
    @spot.latitude = wind_json["associated"]["location"]["lat"]
    @spot.longitude = wind_json["associated"]["location"]["lon"]

    url_subregion_id = scrap_surfline_subregion_id(url_spot_id)
    subregion_id = get_id_location(url_subregion_id)
    @spot.surfline_subregion = subregion_id

    if @spot.save
      flash[:success] = "Spot successfully created"
      redirect_to @spot
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end

    spot_id = get_id_location(url_spot_id)

    create_condition(@spot,spot_id)
  end

end

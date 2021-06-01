require_relative '../../db/spot_scrape'

class SpotsController < ApplicationController
  def index
    @search_message = ""

    if params[:query].present?
      @spots = Spot.search_by_spot_name(params[:query])
      if @spots.size.zero?
        @spot = Spot.new
        create()
        if @spot.save
          @spot = Spot.search_by_spot_name(params[:query])
        else
          @spots = Spot.near(params[:query], 500)
        end
        else
      end
    else
      @spots = Spot.all
    end
    
    @markers = @spots.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude,
        info_window: render_to_string(partial: "info_window", locals: { spot: spot })
      }
    end
    @user_spots = current_user.user_spots
    @spot = Spot.new
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
    if scrap_surfline_spot_id(location_human_to_query(params["query"])) == true
      flash[:alert] = "Sorry, the location you entered is not a Surf spot"
    else
      url_spot_id = scrap_surfline_spot_id(location_human_to_query(params["query"]))
      spot_id = get_id_location(url_spot_id)
      @spot = Spot.new(name: params["query"])
      @spot.surfline_spot = spot_id

      wind_json = call_wind_api(spot_id)
      @spot.latitude = wind_json["associated"]["location"]["lat"]
      @spot.longitude = wind_json["associated"]["location"]["lon"]
      @spot.utc_offset = wind_json["associated"]["utcOffset"]

      url_subregion_id = scrap_surfline_subregion_id(url_spot_id)
      subregion_id = get_id_location(url_subregion_id)
      @spot.surfline_subregion = subregion_id

      if @spot.save
        flash[:alert] = "Spot successfully created"
        redirect_to spots_path
      else
        flash[:alert] = "We couldn't save this spot, please try again later"
        redirect_to spots_path
      end

      spot_id = get_id_location(url_spot_id)
      if @spot.id.nil?
        flash[:alert] = "Spot already exists"
      else
        create_condition(@spot,spot_id)
      end
    end
  end
end

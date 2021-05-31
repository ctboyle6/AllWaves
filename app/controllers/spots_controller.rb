require_relative '../../db/spot_scrape'

class SpotsController < ApplicationController
  def index
    @search_message = ""
    if params[:query].present?
      @spots = Spot.near(params[:query], 400)
      if @spots.size.zero?
        @spots = Spot.search_by_spot_name(params[:query])
        if @spots.size.zero?
          @search_message = "There are no spots matching your search!"
        end
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

    if scrap_surfline_spot_id(location_human_to_query(params[:spot][:name])) == true
      flash[:alert] = "Sorry, the location you entered is not a Surf spot"
      redirect_to spots_path
    else
      url_spot_id = scrap_surfline_spot_id(location_human_to_query(params[:spot][:name]))
      spot_id = get_id_location(url_spot_id)
      @spot = Spot.new(name: params[:spot][:name])
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

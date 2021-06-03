require_relative '../../db/spot_scrape'

class SpotsController < ApplicationController
  def index
    @search_message = ""
    @spots = Spot.all.order("id DESC")

    if params[:query].present?
      @spots = Spot.search_by_spot_name(params[:query]).order("id DESC")
      if @spots.size.zero?
        @spot = Spot.new
        create()
        if @spot.save
          @spot = Spot.search_by_spot_name(params[:query])
        else
          @spots = Spot.near(params[:query], 500).order("id DESC")
        end
      end
    end
    @markers_saved = []
    @markers_new = []
    @user_spots = UserSpot.where(user_id: current_user.id)
    @user_spots.each do |user_spot|
      @markers_saved.push(
          {
            lat: user_spot.spot.latitude,
            lng: user_spot.spot.longitude,
            info_window: render_to_string(partial: "info_window", locals: { spot: user_spot.spot }),
            image_url: helpers.asset_url('saved.png')

          }
        )
    end
    @spots.each do |spot|
      unless @user_spots.select { |user_spot| user_spot.spot_id == spot.id } != []
        @markers_new.push(
          {
          lat: spot.latitude,
          lng: spot.longitude,
          info_window: render_to_string(partial: "info_window", locals: { spot: spot }),
          image_url: helpers.asset_url('wave.png')
        }
      )
    end
  end
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
      flash[:alert] = "Sorry, the location you entered is not a Surf spot. See above for nearby spots"
    else
      url_spot_id = scrap_surfline_spot_id(location_human_to_query(params["query"]))
      spot_id = get_id_location(url_spot_id)
      @spot = Spot.new(name: params["query"].split.map(&:capitalize).join(" "))
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
      else
        flash[:alert] = "We couldn't save this spot, please try again later"
      end

      spot_id = get_id_location(url_spot_id)
      if @spot.id.nil?
        flash[:alert] = "Spot already exists"
      else
        create_condition(@spot, spot_id)
      end
    end
  end
end

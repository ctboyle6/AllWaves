require_relative '../../db/spot_scrape'

class SpotsController < ApplicationController
  def index
    if params[:query].present?
      @spots = Spot.near(params[:query], 200)
    else
      @spots = Spot.all
    end

    @markers = @spots.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude
      }
    end
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
    @spot = Spot.new(params[:name])
    
    
    if @spot.save
      flash[:success] = "Spot successfully created"
      redirect_to @spot
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
    
    url_spot_id = scrap_surfline_spot_id(location_human_to_query(params[:spot][:name]))
    spot_id = get_id_location(url_spot_id)
    
    create_condition(@spot,spot_id)
    
    @spot.latitude = wind_json["associated"]["location"]["lat"]
    @spot.longitude = wind_json["associated"]["location"]["lon"]
  end
  

end

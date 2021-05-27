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
end

class SpotsController < ApplicationController
  def index
    @spots = Spot.all

    @markers = @spots.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude
      }
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end
end

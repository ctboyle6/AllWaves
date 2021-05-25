class SpotsController < ApplicationController

  def index
    @spots = Spot.all
  end

  def show
    @spot =Spot.find(params[:id])
  end

end


class DaysController < ApplicationController
  before_action :set_day_params
  def show
    @day = Result::Day.new(preference: @preference, spot: @spot, date: @date)
  end

  private

  def set_day_params
    @preference = Preference.find(params[:p])
    @spot = Spot.find(params[:s])
    @date = Date.parse(params[:d])
  end
end

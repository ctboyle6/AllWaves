class Result::SpotsController < ApplicationController
  before_action :set_pref_and_spot
  def show
    @result = Result.new(preference: @preference, spot: @spot)
  end

  private

  def set_pref_and_spot
    @preference = Preference.find(params[:preference_id])
    @spot = Spot.find(params[:id])
  end
end

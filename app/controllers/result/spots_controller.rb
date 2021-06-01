class Result::SpotsController < ApplicationController
  before_action :set_pref_and_spot
  def show # render :action
    @result = Result.new(preference: @preference, spot: @spot)
    # respond_to do |format|
    #   format.html
    #   format.json { render json: { result: @result } }
    #   format.js
    # end
  end

  private

  def set_pref_and_spot
    @preference = Preference.find(params.dig(:result, :preference_id))
    @spot = Spot.find(params.dig(:result, :spot_id))
  end
end

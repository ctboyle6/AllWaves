class DashboardsController < ApplicationController
  def show
    @user_spots = current_user.user_spots
    if params[:spot_id].present?
      set_pref_and_spot
      @result = Result.new(preference: @preference, spot: @spot)
    end
  end

  private

  def set_pref_and_spot
    @preference = Preference.find(params[:preference_id])
    @spot = Spot.find(params[:spot_id])
  end
end

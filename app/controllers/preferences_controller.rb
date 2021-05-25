class PreferencesController < ApplicationController
  def index
    @preferences = policy_scope(Preference)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def preference_params
    params.require(:preference).permit(:name, :pref_unit, :pref_swell_height,
                                       :pref_swell_int, :pref_swell_direction,
                                       :pref_wind_strength, :pref_wind_direction,
                                       :pref_tide_position, :pref_tide_range)
  end
end

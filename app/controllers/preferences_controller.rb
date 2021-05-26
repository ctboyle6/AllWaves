class PreferencesController < ApplicationController
  before_action :set_preference, only: [:show]

  def index
    @preferences = policy_scope(Preference)
  end

  def show; end

  def new
    @preference = Preference.new
    authorize(@preference)
  end

  def create
    # TODO: fix form to send all params on submit
    raise params.inspect
    @preference = Preference.new(preference_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_preference
    @preference = Preference.find(params[:id])
    authorize(@preference)
  end

  def preference_params
    params.require(:preference).permit(:name, :pref_unit, :pref_swell_height,
                                       :pref_swell_int, :pref_swell_direction,
                                       :pref_wind_strength, :pref_wind_direction,
                                       :pref_tide_position, :pref_tide_range)
  end
end

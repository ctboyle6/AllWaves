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
    @preference = Preference.new(preference_params)
    @preference.user = current_user
    authorize @preference
    if @preference.save
      redirect_to preference_path(@preference)
    else
      render :new
    end
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
    params.require(:preference).permit(:name, :pref_unit, :swell_hgt_min, :swell_hgt_max,
                                       :swell_int_min, :swell_int_max, :swell_dir_min,
                                       :swell_dir_max, :wind_str_min, :wind_str_max,
                                       :wind_dir_min, :wind_dir_max,
                                       :pref_tide_position, :pref_tide_range)
  end
end

class PreferencesController < ApplicationController
  before_action :set_preference, only: [:show, :edit, :update, :destroy]

  def index
    @preferences = policy_scope(Preference)
    @preference = Preference.new
  end

  def show; end

  def new
    @preference = Preference.new(swell_hgt_min: 10, swell_hgt_max: 20, swell_int_min: 10, swell_int_max: 20,
                                 swell_dir_min: 90, swell_dir_max: 270, wind_str_min: 15, wind_str_max: 35,
                                 wind_dir_min: 90, wind_dir_max: 270, pref_tide_position: 'NORMAL',
                                 pref_unit: 'FT')
    authorize(@preference)
  end

  def create
    @preference = Preference.new(preference_params)
    falsify_favourites! if @preference.favourite
    @preference.user = current_user
    authorize @preference
    if @preference.save
      redirect_to preferences_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @preference.update(preference_params)
      falsify_favourites! if @preference.favourite
      redirect_to preferences_path
    else
      render :edit
    end
  end

  def destroy
    redirect_to preferences_path if @preference.destroy
  end

  private

  def falsify_favourites!
    all_but_current = Preference.where(user: current_user).where.not(id: @preference.id)
    all_but_current.each do |pref|
      pref.favourite = false
      pref.save
    end
  end

  def set_preference
    @preference = Preference.find(params[:id])
    authorize(@preference)
  end

  def preference_params
    params.require(:preference).permit(:name, :pref_unit, :swell_hgt_min, :swell_hgt_max,
                                       :swell_int_min, :swell_int_max, :swell_dir_min,
                                       :swell_dir_max, :wind_str_min, :wind_str_max,
                                       :wind_dir_min, :wind_dir_max,
                                       :pref_tide_position, :pref_tide_range, :favourite)
  end
end

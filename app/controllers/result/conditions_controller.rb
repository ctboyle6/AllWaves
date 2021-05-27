class Result::ConditionsController < ApplicationController
  before_action :set_pref_conds
  def show
    @wind = wind?
    @waves = waves?
  end

  def wind?
    strength = @c.wind_strength >= @p.wind_str_min && @c.wind_strength <= @p.wind_str_max
    direction = @c.wind_direction >= @p.wind_dir_min && @c.wind_direction <= @p.wind_dir_max
    strength && direction
  end

  def waves?
    direction = @c.waves_swell_direction >= @p.swell_dir_min && @c.waves_swell_direction <= @p.swell_dir_max
    period = @c.waves_swell_period >= @p.swell_int_min && @c.waves_swell_period <= @p.swell_int_max
    height = @c.waves_swell_height >= @p.swell_hgt_min && @c.waves_swell_height <= @p.swell_hgt_max
    direction && period && height
  end

  def tide?

  end

  def go?
    wind? && waves? && tide?
  end


  private

  def set_pref_conds
    @p = Preference.find(params[:preference_id])
    @c = Condition.find(params[:id])
  end
end

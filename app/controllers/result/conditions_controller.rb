require 'date'
class Result::ConditionsController < ApplicationController
  before_action :set_day_conditions
  def show
    @go_array = go?(@days_conditions)
  end

  def wind?(condition)
    strength = condition.wind_strength >= @p.wind_str_min && condition.wind_strength <= @p.wind_str_max
    direction = condition.wind_direction >= @p.wind_dir_min && condition.wind_direction <= @p.wind_dir_max
    strength && direction
    # true
  end

  def waves?(condition)
    direction = condition.waves_swell_direction >= @p.swell_dir_min && condition.waves_swell_direction <= @p.swell_dir_max
    period = condition.waves_swell_period >= @p.swell_int_min && condition.waves_swell_period <= @p.swell_int_max
    height = condition.waves_swell_height >= @p.swell_hgt_min && condition.waves_swell_height <= @p.swell_hgt_max
    direction && period && height
  end

  def tide?(condition)
    condition.tide_type == @p.pref_tide_position
  end

  def go?(conditions)
    @go_array = conditions.map do |condition|
      [waves?(condition), wind?(condition), tide?(condition)].all?(&:present?)
    end
  end

  private

  def set_day_conditions
    set_pref_spot
    timestamp = Date.today.midnight.to_i + (10 * 3600) # TODO: hardcoded time > dynamic
    # @days_conditions = Condition.where("time_at BETWEEN ? AND ?", DateTime.current.midnight, DateTime.current.end_of_day).where(spot: @spot)
    @days_conditions = Condition.where("timestamp BETWEEN ? AND ?", timestamp, timestamp + (24 * 6 * 3600)).where(spot: @spot)
  end

  def set_pref_spot
    @p = Preference.find(params[:preference_id])
    @spot = Condition.find(params[:id]).spot
  end
end

require 'date'
class Result::ConditionsController < ApplicationController
  before_action :set_pref_and_spot
  def show
    @result = Result.create(preference: @preference, spot: @spot)
  end

  private

  def set_pref_and_spot
    @preference = Preference.find(params[:preference_id])
    @spot = Condition.find(params[:id]).spot
  end
end

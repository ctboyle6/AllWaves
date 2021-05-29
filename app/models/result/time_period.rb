class Result
  class TimePeriod
    def initialize(params = {})
      @condition  = params[:condition]
      @preference = params[:preference]
    end

    def go?
      tides_good? && winds_good? && waves_good?
    end

    private

    def tides_good?
      @condition.tide_type.downcase == @preference.pref_tide_position.downcase
    end

    def winds_good?
      @preference.wind_d_range.include?(@condition.wind_direction)
      @preference.wind_s_range.include?(@condition.strength)
    end

    def waves_good?
      preference.swell_h_range.include?(@condition.waves_swell_height)
      preference.swell_p_range.include?(@condition.waves_swell_period)
      preference.swell_d_range.include?(@condition.waves_swell_direction)
    end
  end
end

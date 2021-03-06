class Result
  class TimePeriod
    attr_reader :condition
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
      dir = @preference.wind_d_range.include?(@condition.wind_direction)
      str = @preference.wind_s_range.include?(@condition.wind_strength)
      dir && str
    end

    def waves_good?
      ht = @preference.swell_h_range.include?(@condition.waves_swell_height)
      per = @preference.swell_p_range.include?(@condition.waves_swell_period)
      dir = @preference.swell_d_range.include?(@condition.waves_swell_direction)
      ht && per && dir
    end
  end
end

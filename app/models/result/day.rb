class Result
  class Day
    attr_reader :date

    def initialize(params)
      @date       = params[:date] || Date.today
      @preference = params[:preference]
      @spot       = params[:spot]
    end

    def time_periods
      conditions.map do |condition|
        Result::TimePeriod.new(condition: condition, preference: @preference)
      end
    end

    def any_go?
      time_periods.any?(&:go?)
    end

    private

    def conditions
      # TODO: Add Spot.utc (seed file update) to @date to make tz dynamic
      Condition.where(spot: @spot).where("timestamp BETWEEN ? AND ?", @date.midnight.to_i - utc_seconds, @date.tomorrow.midnight.to_i - utc_seconds - 1)
    end

    def utc_seconds
      @spot.utc_offset * 3600
    end
  end
end

class Result
  class Day
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
      # Use spot to query with AR for the conditions
      # Condition.where(spot: @spot).where("BETWEEN STUFF")
      Condition.where(spot: @spot).where("timestamp BETWEEN ? AND ?", @date.midnight.to_i, Date.tomorrow.midnight.to_i)
    end
  end
end

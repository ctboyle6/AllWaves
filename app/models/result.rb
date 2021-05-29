class Result
  attr_reader :spot
  def initialize(params)
    @preference = params[:preference]
    @spot       = params[:spot]

    @start_date = params[:start_date] || Date.today
    @days_count = params[:days_count] || 5
    @end_date   = @start_date + @days_count
  end

  def days
    (@start_date..@end_date).map do |date|
      Day.new(preference: @preference, spot: @spot, date: date)
    end
  end
end

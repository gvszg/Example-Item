class TimeUntil
  # attr_reader :time_range

  TIME_RANGE = {
    "month" => Range.new((Time.now - 30.day), Time.now),
    "week" => Range.new((Time.now - 7.day), Time.now),
    "day" => Range.new((Time.now - 1.day), Time.now)
  }

  def self.time_within(time_range)
    TIME_RANGE[time_range]
  end
end
class TimeInterval < ActiveRecord::Type::Value

  def cast(value)
    it = ISO8601::TimeInterval.new(value)
    it.start_time.to_time
  end

  def serialize(value)
  end

end

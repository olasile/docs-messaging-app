class ActiveSupport::TimeWithZone
  def to_usa
    self.strftime('%m/%d/%y')
  end
end

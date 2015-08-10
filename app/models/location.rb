class Location
  attr_reader :code
  def initialize(code)
    @code = code
  end

  def self.success_or_fail(distance)
    distance[12...16].to_i < 20
  end
end

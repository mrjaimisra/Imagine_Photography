class Zipcode
  attr_reader :code
  def initialize(code)
    @code = code
  end

  def allowed?
    zipcodes.include?(code)
  end

  def zipcodes
    [
      "12345",
      "67890",
      "64347",
      "63119",
      "64784"
    ]
  end
end

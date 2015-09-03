class CartPhoto < SimpleDelegator
  attr_reader :quantity,
              :photo

  def initialize(photo, quantity = 0)
    super(photo)
    @photo = photo
    @quantity = quantity
  end
end

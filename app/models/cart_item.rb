class CartItem < SimpleDelegator
  attr_reader :quantity,
              :item

  def initialize(item, quantity = 0)
    super(item)
    @item = item
    @quantity = quantity
  end

  def subtotal
    @item.price * quantity
  end
end

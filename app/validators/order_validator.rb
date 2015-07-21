class OrderValidator < ActiveModel::Validator
  def validate(order)
    # Do nothing for now.
    # We must create an order before we create an order_item,
    # so the initial order must temporarily not have any order items
    unless order.order_items.length >= 1
     order.errors.add(:order_item, "order must have at least 1 order item")
    end
  end
end

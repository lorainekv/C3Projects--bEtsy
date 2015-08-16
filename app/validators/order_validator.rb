class OrderValidator < ActiveModel::Validator
  def validate(order)
    unless order.order_items.length >= 1
     order.errors.add(:order_item, "order must have at least 1 order item")
    end
  end
end

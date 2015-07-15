require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "order model validations" do
    it "must have one or more order items" do
      order = Order.new(id: 1)
      order_item = OrderItem.new(id: 1, quantity: 3, order_id: 1)
      order_item.save
      order_item2 = OrderItem.create(id: 2, quantity: 4, order_id: 1)
      order.save

      expect(order).to be_valid
    end


  end


end

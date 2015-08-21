require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "model validations" do
    it "must have a quantity" do
      order_item = OrderItem.new
      expect(order_item).to_not be_valid
      expect(order_item.errors.keys).to include(:quantity)
    end
    it "quantity must be an integer" do
      order_item = OrderItem.new(quantity: "")
      expect(order_item).to_not be_valid
      expect(order_item.errors.keys).to include(:quantity)
    end
    it "requires quantity to be greater than 0" do
      order_item = OrderItem.new(quantity: -1)
      expect(order_item).to_not be_valid
    end
  end


end

class AddShippingToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :shipping, :string
  end
end

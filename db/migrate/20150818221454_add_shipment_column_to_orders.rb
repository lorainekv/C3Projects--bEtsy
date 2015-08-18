class AddShipmentColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipment_id, :integer, index: true
  end
end

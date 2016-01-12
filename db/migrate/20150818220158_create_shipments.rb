class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :address1, null: false
      t.string :address2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :country, null: false, default: "US"
      t.string :carrier
      t.string :delivery
      t.decimal :shipping_cost, precision: 7, scale: 2
      t.integer :order_id, null: false, index: true
      t.timestamps null: false
    end
  end
end

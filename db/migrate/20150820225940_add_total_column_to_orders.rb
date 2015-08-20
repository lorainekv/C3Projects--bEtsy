class AddTotalColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total, :decimal, precision: 7, scale: 2
  end
end

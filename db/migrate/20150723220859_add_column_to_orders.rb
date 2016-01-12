class AddColumnToOrders < ActiveRecord::Migration
  def change
      add_column :orders, :zipcode, :integer
  end
end

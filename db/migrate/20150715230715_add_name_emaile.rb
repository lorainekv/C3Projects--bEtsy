class AddNameEmaile < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :email, :string
    add_column :orders, :address, :string
    add_column :orders, :cc4, :integer
    add_column :orders, :expiry_date, :datetime
  end
end

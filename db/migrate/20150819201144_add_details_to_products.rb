class AddDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :weight, :string
    add_column :products, :dimensions, :string
  end
end

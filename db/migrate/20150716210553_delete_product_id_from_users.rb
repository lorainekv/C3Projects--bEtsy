class DeleteProductIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :product_id, :integer
  end
end

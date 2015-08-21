class DeleteNameEmaileAddressCc4CcExpFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name, :string
    remove_column :users, :email, :string
    remove_column :users, :address, :string
    remove_column :users, :cc4, :integer
    remove_column :users, :expiry_date, :datetime
  end
end

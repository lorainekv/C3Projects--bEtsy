class AddLimitToCc < ActiveRecord::Migration
  def change
    change_column :orders, :cc4, :integer, :limit => 8
  end

end

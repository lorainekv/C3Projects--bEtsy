class ChangeColumnNamesInShipmentModel < ActiveRecord::Migration
  def change
    rename_column :shipments, :zip, :zipcode
    rename_column :shipments, :address1, :address
  end
end

class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.integer :stock, :default => 0
      t.string :photo_url
      t.integer :user_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end

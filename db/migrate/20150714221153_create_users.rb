class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :username
      t.string :password_digest
      t.integer :cc4
      t.datetime :expiry_date
      t.string :role

      t.timestamps null: false
    end
  end
end

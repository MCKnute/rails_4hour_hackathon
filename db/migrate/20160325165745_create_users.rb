class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :borrow_reason
      t.text :borrow_description
      t.float :money
      t.integer :account_type

      t.timestamps null: false
    end
  end
end

class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.float :loan
      t.integer :lender_id, :null => false
      t.integer :borrower_id, :null => false

      t.timestamps null: false
    end
  end
end

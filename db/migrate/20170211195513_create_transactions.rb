class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :admin_id
      t.integer :user_id
      t.float :amount
      t.timestamps
    end
  end
end

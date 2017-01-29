class AddNameBalanceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string, default: ""
    add_column :users, :balance, :float, default: 0.0
  end
end

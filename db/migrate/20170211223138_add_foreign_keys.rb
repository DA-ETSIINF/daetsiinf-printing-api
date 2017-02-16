class AddForeignKeys < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :documents, :users, column: 'user_id', on_delete: :cascade
    add_foreign_key :documents, :folders, column: 'folder_id', on_delete: :cascade
    add_foreign_key :folders, :users, column: 'user_id', on_delete: :cascade
    add_foreign_key :transactions, :users, column: 'user_id'
    add_foreign_key :transactions, :users, column: 'admin_id'
  end
end

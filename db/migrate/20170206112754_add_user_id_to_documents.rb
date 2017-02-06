class AddUserIdToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :user_id, :integer
    add_index :documents, :user_id
  end
end

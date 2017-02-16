class UpdateIndexDocuments < ActiveRecord::Migration[5.0]
  def change
    remove_index :documents, :folder_id
    add_column :documents, :user_id, :integer
    add_index :documents, :user_id
  end
end

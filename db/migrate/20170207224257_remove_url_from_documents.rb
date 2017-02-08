class RemoveUrlFromDocuments < ActiveRecord::Migration[5.0]
  def change
    remove_column :documents, :url, :string
  end
end

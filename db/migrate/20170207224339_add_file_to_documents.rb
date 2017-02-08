class AddFileToDocuments < ActiveRecord::Migration[5.0]
  def up
    add_attachment :documents, :file
  end

  def down
    remove_attachment :documents, :file
  end
end

class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :name, default: ""
      t.string :url, default: ""
      t.integer :pages, default: 0
      t.integer :folder_id

      t.timestamps
    end
    add_index :documents, :folder_id
  end
end

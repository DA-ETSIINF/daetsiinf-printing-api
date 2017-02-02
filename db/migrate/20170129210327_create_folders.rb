class CreateFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :folders do |t|
      t.string :name, default: ""
      t.integer :user_id

      t.timestamps
    end
    add_index :folders, :user_id
  end
end

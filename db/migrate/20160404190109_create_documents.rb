class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.attachment :file
      
      t.timestamps
    end

    add_index :documents, :user_id
  end
end

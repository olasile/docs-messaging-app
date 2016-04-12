class CreateContactsFile < ActiveRecord::Migration
  def change
    create_table :contacts_files do |t|
      t.integer :user_id
      t.attachment :file
      
      t.timestamps
    end

    add_column :users, :contacts_files_count, :integer, default: 0

    add_index :contacts_files, :user_id
  end
end

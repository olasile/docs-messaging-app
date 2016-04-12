class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :body
      t.boolean :readed, default: false
      t.integer :contacts_user_id
      
      t.timestamps
    end

    add_index :messages, :contacts_user_id
  end
end

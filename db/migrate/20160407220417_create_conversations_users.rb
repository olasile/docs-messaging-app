class CreateConversationsUsers < ActiveRecord::Migration
  def change
    create_table :conversations_users do |t|
      t.integer :user_id
      t.integer :conversation_id

      t.timestamps
    end

    add_index :conversations_users, :user_id
    add_index :conversations_users, :conversation_id
  end
end

class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :messages_count, default: 0
      t.timestamps
    end
  end
end

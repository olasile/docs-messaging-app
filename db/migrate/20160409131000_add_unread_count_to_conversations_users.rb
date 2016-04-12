class AddUnreadCountToConversationsUsers < ActiveRecord::Migration
  def up
    add_column :conversations_users, :unread, :boolean, default: false
  end

  def down
    remove_column :conversations_users, :unread
  end
end

class AddConversationIdToMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :contacts_user_id, :conversation_id


    remove_column :messages, :readed

    add_column :messages, :readed, :integer, array: true, default: []
  end
end

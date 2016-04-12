class AddCounterCache < ActiveRecord::Migration
  def up
    add_column :users, :contacts_users_count, :integer, default: 0
    add_column :users, :documents_count, :integer, default: 0
    add_column :contacts_users, :messages_count, :integer, default: 0
    add_column :companies, :users_count, :integer, default: 0
  end

  def down
    remove_column :users, :contacts_users_count
    remove_column :users, :documents_count
    remove_column :contacts_users, :messages_count
    remove_column :companies, :users_count
  end
end

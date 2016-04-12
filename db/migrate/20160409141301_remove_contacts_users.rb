class RemoveContactsUsers < ActiveRecord::Migration
  def change
    drop_table :contacts_users
  end
end

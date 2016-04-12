class CreateUsersUsers < ActiveRecord::Migration
  def change
    create_table :contacts_users do |t|
      t.integer :user_id
      t.integer :contact_id

      t.timestamps
    end

    add_index :contacts_users, :user_id
    add_index :contacts_users, :contact_id
  end
end

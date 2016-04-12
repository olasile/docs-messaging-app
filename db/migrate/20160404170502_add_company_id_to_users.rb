class AddCompanyIdToUsers < ActiveRecord::Migration
  def up
    add_column :users, :company_id, :integer
    add_index :users, :company_id
  end

  def down
    remove_column :users, :company_id
  end
end

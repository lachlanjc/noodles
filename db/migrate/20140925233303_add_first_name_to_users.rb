class AddFirstNameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
  end

  def down
    remove_column :users, :name
  end
end

class AddPrivateSharingToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :private_share, :boolean
    add_column :recipes, :private_id, :string
  end
end

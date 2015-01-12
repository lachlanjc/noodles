class AddSharedIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :shared_id, :string
  end
end

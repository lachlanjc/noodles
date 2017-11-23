class AddSharedIdToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :shared_id, :string
  end
end

class AddSharedToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :shared, :boolean
  end
end

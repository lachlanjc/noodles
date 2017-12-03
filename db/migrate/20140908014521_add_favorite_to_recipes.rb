class AddFavoriteToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :favorite, :boolean
  end
end

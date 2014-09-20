class AddFavoriteToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :favorite, :boolean
  end
end

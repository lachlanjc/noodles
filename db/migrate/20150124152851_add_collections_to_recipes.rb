class AddCollectionsToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :collections, :text, array: true, default: []
  end
end

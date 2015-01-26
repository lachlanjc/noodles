class AddCollectionsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :collections, :text, array: true, default: []
  end
end

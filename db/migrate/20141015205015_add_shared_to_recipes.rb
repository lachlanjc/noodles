class AddSharedToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :shared, :boolean
  end
end

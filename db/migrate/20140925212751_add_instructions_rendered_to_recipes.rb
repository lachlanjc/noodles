class AddInstructionsRenderedToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :instructions_rendered, :text
  end
end

class AddInstructionsRenderedToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :instructions_rendered, :text
  end
end

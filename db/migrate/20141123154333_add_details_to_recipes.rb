class AddDetailsToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :source, :string
    add_column :recipes, :notes, :text
    add_column :recipes, :serves, :string
  end
end

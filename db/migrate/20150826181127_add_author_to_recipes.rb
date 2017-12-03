class AddAuthorToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :author, :string
  end
end

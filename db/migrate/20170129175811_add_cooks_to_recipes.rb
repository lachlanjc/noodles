class AddCooksToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :last_cooked_at, :datetime
    add_column :recipes, :cooks_count, :integer, default: 0
  end
end

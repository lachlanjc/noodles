class AddCooksToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :last_cooked_at, :datetime
    add_column :recipes, :cooks_count, :integer, default: 0
  end
end

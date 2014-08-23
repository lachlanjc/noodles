class AddColumnUserIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :user_id, :integer
  end
end

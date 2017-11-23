class AddColumnUserIdToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :user_id, :integer
  end
end

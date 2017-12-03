class CreateRecipes < ActiveRecord::Migration[4.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :ingredients
      t.text :instructions

      t.timestamps
    end
  end
end

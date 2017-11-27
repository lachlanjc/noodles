class CreateGroceries < ActiveRecord::Migration[5.1]
  def change
    create_table :groceries do |t|
      t.text :name
      t.datetime :completed_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

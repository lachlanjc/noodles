class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :content
      t.text :content_raw
      t.string :shared_id, index: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

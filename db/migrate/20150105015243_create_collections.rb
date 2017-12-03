class CreateCollections < ActiveRecord::Migration[4.2]
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.attachment :photo
      t.references :user, index: true

      t.timestamps
    end
  end
end

class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :body
      t.text :body_rendered
      t.integer :author_id
      t.boolean :mail

      t.timestamps
    end
  end
end

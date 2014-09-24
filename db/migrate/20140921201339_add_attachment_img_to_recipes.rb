class AddAttachmentImgToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :recipes, :img
  end
end

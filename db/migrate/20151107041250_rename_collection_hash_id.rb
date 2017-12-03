class RenameCollectionHashId < ActiveRecord::Migration[4.2]
  def change
    rename_column :collections, :hash_id, :shared_id
  end
end

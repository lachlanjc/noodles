class RenameCollectionHashId < ActiveRecord::Migration
  def change
    rename_column :collections, :hash_id, :shared_id
  end
end

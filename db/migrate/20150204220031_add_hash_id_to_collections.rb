class AddHashIdToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :hash_id, :string
  end
end

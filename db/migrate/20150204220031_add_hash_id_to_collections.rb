class AddHashIdToCollections < ActiveRecord::Migration[4.2]
  def change
    add_column :collections, :hash_id, :string
  end
end

class AddNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :want_newsletter, :boolean
  end
end

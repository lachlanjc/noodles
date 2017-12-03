class AddNewsletterToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :want_newsletter, :boolean
  end
end

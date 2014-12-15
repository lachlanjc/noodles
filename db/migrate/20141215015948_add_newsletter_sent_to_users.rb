class AddNewsletterSentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newsletter_sent, :boolean
  end
end

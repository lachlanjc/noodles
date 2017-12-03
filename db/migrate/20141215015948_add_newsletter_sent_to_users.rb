class AddNewsletterSentToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :newsletter_sent, :boolean
  end
end

class AddSubscriptionsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_customer, :string
    add_column :users, :stripe_subscription, :string
    add_column :users, :subscribed_at, :datetime, default: nil
  end
end

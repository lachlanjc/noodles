module HRHelpers
  include AnalyticsHelper

  def find_person(user)
    Highrise::Person.search(contact_data: { email_address: user.email })
  end

  def new_highrise_person(user = @user)
    Highrise::Person.new({
      first_name: user.first_name,
      contact_data: {
        email_addresses: [ { address: user.email, location: 'Home' } ],
        user_id: user.id,
        signed_up: user.created_at,
        referred_by: user.referring_url,
        recipe_count: user_recipe_count(user),
        shared_recipe_count: user_shared_recipe_count(user),
        collection_count: user_collection_count(user)
      }
    })
  end

  def create_person!(user)
    @user = user
    new_highrise_person.save
    user.highrise = true
    user.save
  end
end

module HR
  include HRHelpers

  def add_new_users!(users = [])
    users.each do |user|
      create_person!(user) if find_person(user).blank?
    end
  end
end

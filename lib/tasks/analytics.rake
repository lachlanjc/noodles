require Rails.root.join 'lib/highrise.rb'

namespace :analytics do
  desc 'Set initial Highrise user values'
  task highrise_all_users: :environment do
    User.where('highrise IS NULL').find_each do |user|
      user.highrise = find_person(user)
    end
  end

  desc 'Add all new users to Highrise'
  task add_new_users: :environment do
    @new_users = []
    User.where('highrise IS NULL').find_each do |user|
      @new_users.push(user)
    end
    HighriseIntegration.add_new_users! @new_users
  end
end

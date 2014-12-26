namespace :newsletter do
  desc 'Set want_newsletter to true for all users'
  task :want_true => :environment do
    User.all.each do |user|
      user.want_newsletter = true
      user.save
    end
    puts 'Finished!'
  end

  desc 'Set newsletter_sent to false for all users'
  task :sent_false => :environment do
    User.all.each do |user|
      user.newsletter_sent = false
      user.save
    end
    puts 'Finished!'
  end

  desc 'Send the newsletter out to every user'
  task :send_it => :environment do
    User.where(:newsletter_sent => false, :want_newsletter => true).each do |user|
      NewsletterMailer.newsletter(user).deliver
      puts 'Email delivered to ' + user.email
      user.newsletter_sent = true
      user.save
    end
    puts 'Finished!'
  end

  desc 'Send the newsletter to LJC'
  task :test_send => :environment do
    NewsletterMailer.newsletter(User.find(1)).deliver
    puts 'And he\'s off!'
  end
end

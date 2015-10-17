namespace :newsletter do
  desc 'Set newsletter_sent to false for all users'
  task sent_false: :environment do
    User.all.each do |user|
      user.newsletter_sent = false
      user.save
    end
    puts 'Finished!'
  end

  desc 'Send the newsletter out to every user'
  task send_it: :environment do
    User.where(newsletter_sent: false, want_newsletter: true).each do |user|
      NewsletterMailer.newsletter(user).deliver_now
      puts 'Email delivered to ' + user.email
      user.newsletter_sent = true
      user.save
    end
    puts 'Finished!'
  end

  desc 'Send the newsletter to LJC'
  task test_send: :environment do
    NewsletterMailer.newsletter(User.find(1)).deliver_now
    puts 'And he\'s off!'
  end

  desc 'Send a test newsletter to anyone'
  task :test_send_anyone, [:email] => [:environment] do |t, args|
    user = User.new(email: args[:email], id: 1)
    NewsletterMailer.newsletter(user).deliver_now
    puts 'And he\'s off!'
  end

  desc 'Re-subscribe everyone'
  task want_true: :environment do
    User.all.each do |user|
      user.want_newsletter = true
      user.save
    end
    puts 'Finished!'
  end
end

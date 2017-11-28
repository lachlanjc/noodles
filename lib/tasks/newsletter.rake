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
    User.where(newsletter_sent: false).where('created_at < ?', 1.day.ago).each do |user|
      NewsletterMailer.newsletter(user.email).deliver_now
      puts 'Email delivered to ' + user.email
      user.newsletter_sent = true
      user.save
    end
    puts 'Finished!'
  end

  desc 'Send the newsletter to LJC'
  task test_send: :environment do
    NewsletterMailer.newsletter(User.first.email).deliver_now
    puts 'And they’re off! ' + User.first.email
  end

  desc 'Send a test newsletter to anyone'
  task :test_send_to, [:email] => [:environment] do |t, args|
    NewsletterMailer.newsletter(args[:email]).deliver_now
    puts 'And they’re off! ' + args[:email].to_s
  end
end

class NewsletterMailer < ActionMailer::Base
  default from: 'Lachlan Campbell <noodles@lachlanjc.com>'
  layout 'newsletter_mailer'

  def newsletter(email)
    mail(to: email, subject: 'Noodles 2.0 is LIVE!')
  end
end

class NewsletterMailer < ActionMailer::Base
  default from: 'Lachlan Campbell <lachlan@getnoodl.es>'
  layout 'newsletter_mailer'

  def newsletter(user)
    @subject = 'Noodles News: New Cook Mode, Ingredient Sections, Authors, and more!'
    @unsub = Rails.application.routes.url_helpers.unsubscribe_path(code: rand(32**8).to_s(32), user_id: user.id)
    mail(to: user.email, subject: @subject)
  end
end

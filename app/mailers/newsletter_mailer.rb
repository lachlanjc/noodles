class NewsletterMailer < ActionMailer::Base
  default from: 'lachlan@getnoodl.es'

  def newsletter(user)
    @subject = '[Noodles] Thank you + a lot of updates'
    mail(to: user.email, subject: @subject)
  end
end

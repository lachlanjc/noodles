class NewsletterMailer < ActionMailer::Base
  default from: 'lachlan@getnoodl.es'

  def newsletter(user)
    @subject = '[Noodles] Web Import, Search, better sharing, and more.'
    @id = user.id
    mail(to: user.email, subject: @subject)
  end
end

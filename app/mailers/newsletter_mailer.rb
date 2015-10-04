class NewsletterMailer < ActionMailer::Base
  default from: 'Lachlan Campbell <lachlan@getnoodl.es>'

  def newsletter(user)
    @subject = '[Noodles] Collections, PDF Export, Embed, and more.'
    @id = user.id
    mail(to: user.email, subject: @subject)
  end
end

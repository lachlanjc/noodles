class NewsletterMailer < ActionMailer::Base
  default from: 'lachlan@getnoodl.es'

  def newsletter(user)
    @subject = '[Noodles] Ingredient checklists, remember your experiences, and more.'
    @id = user.id
    mail(to: user.email, subject: @subject)
  end
end

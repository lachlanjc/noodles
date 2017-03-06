class EmailMeJob < ApplicationJob
  include TextHelper

  def perform(data)
    return if Rails.env.test?
    Aws::SES::Client.new.send_email({
      destination: {
        to_addresses: [
          'lachlan@getnoodl.es'
        ],
      },
      message: {
        body: {
          html: {
            charset: 'UTF-8',
            data: markdown(data[:body]),
          },
          text: {
            charset: 'UTF-8',
            data: data[:body],
          },
        },
        subject: {
          charset: 'UTF-8',
          data: data[:subject],
        },
      },
      source: 'Noodles <app@getnoodl.es>'
    })
  end
end

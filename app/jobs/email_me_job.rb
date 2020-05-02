class EmailMeJob < ApplicationJob
  include TextHelper

  def perform(props)
    return unless Rails.env.production?
    Aws::SES::Client.new.send_email(destination: {
                                      to_addresses: [
                                        'noodles@lachlanjc.com'
                                      ]
                                    },
                                    message: {
                                      body: {
                                        html: {
                                          charset: 'UTF-8',
                                          data: markdown(props[:body])
                                        },
                                        text: {
                                          charset: 'UTF-8',
                                          data: props[:body]
                                        }
                                      },
                                      subject: {
                                        charset: 'UTF-8',
                                        data: props[:subject]
                                      }
                                    },
                                    source: "Noodles <#{Rails.env}@getnoodl.es>")
  end
end

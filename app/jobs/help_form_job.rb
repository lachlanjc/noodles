class HelpFormJob < ApplicationJob
  include TextHelper

  def perform(data)
    body = generate_body(data[:email], data[:message], data[:url])
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
            data: markdown(body),
          },
          text: {
            charset: 'UTF-8',
            data: body,
          },
        },
        subject: {
          charset: 'UTF-8',
          data: "Help request, #{Time.now.to_formatted_s(:short)}",
        },
      },
      reply_to_addresses: [
        data[:email]
      ],
      source: 'Noodles Help <help@getnoodl.es>'
    })
  end

  private

  def generate_body(email, message, url)
    [
      message,
      # "_" * 3,
      generate_footer(email, url)
    ].join("\n" * 2)
  end

  def generate_footer(email, url)
    user_desc = "visitor"
    if user = User.find_by_email(email)
      subscriber = user.subscriber? ? "🌟✅ SUBSCRIBER" : "❌ Not a subscriber"
      user_desc = "#{user.first_name}, #{user.email}, #{subscriber}"
    end
    [
      "- Timestamp: #{Time.now.to_formatted_s(:long)}",
      "- URL: #{url}",
      "- User: #{user_desc}"
    ].join("\n")
  end
end

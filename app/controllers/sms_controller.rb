class SmsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def groceries
    @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
    if ['groceries', 'grocery list', 'list'].include? params['Body'].downcase
      send_message Grocery.all.active.pluck(:name).join("\n")
    else
      Grocery.create name: params['Body'], user: User.first
      send_message 'Saved! (Reply List for all)'
    end
    head :no_content
  end

  private

  def send_message(body)
    @client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: params['From'],
      body: body
    )
  end
end

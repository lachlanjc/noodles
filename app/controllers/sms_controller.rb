# frozen_string_literal: true

class SmsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def groceries
    @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
    @user = User.find_by phone: params['From'].to_i.to_s
    if @user.blank?
      send_message 'Noodles doesn’t recognize your number. Add it: https://getnoodl.es/groceries'
    elsif ['groceries', 'grocery list', 'list'].include? params['Body'].downcase
      send_message @user.groceries.active.pluck(:name).join("\n") + "\n" + 'https://getnoodl.es/groceries'
    else
      Grocery.create name: params['Body'].to_s.squish, user: @user
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

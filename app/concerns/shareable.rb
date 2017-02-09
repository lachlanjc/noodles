# Shareable generates public links and social network links
module Shareable
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers
  include ActionDispatch::Routing::UrlFor

  included do
    validates :shared_id,
      presence: true,
      length: { minimum: 2 },
      uniqueness: true

    before_validation :generate_shared_id,
      on: :create
    after_validation :regenerate_shared_id,
      on: :create,
      if: proc { |object| object.errors.any? }
  end

  def generate_shared_id
    self.update_attribute(:shared_id, make_shared_id)
  end
  alias_method :regenerate_shared_id, :generate_shared_id

  def type
    self.class.name.downcase
  end

  def publisher
    user.first_name
  end

  def media_url
    photo_url || "#{root_url}/logo.png"
  end

  def twitter_url
    social_network(:twitter, '/share', text: "#{self.name} (published on @noodlesapp)", url: self.public_url)
  end

  def facebook_url
    social_network(:facebook, '/sharer/sharer.php', u: self.public_url)
  end

  def pinterest_url
    social_network(:pinterest, '/pin/create/button', url: self.public_url, media: media_url, description: "#{self.name} (published on Noodles)")
  end

  def email_url
    body = "#{self.name} (published on Noodles): #{self.public_url}"
    "mailto:?subject=#{self.name}&body=#{body}"
  end

  private

  def make_shared_id
    rand(16**4).to_s(32)
  end

  def social_network(name, sharer, options = {})
    "https://#{name}.com#{sharer}?#{options.to_query}"
  end
end

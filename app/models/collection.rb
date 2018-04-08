class Collection < ApplicationRecord
  belongs_to :user, touch: true
  has_many :recipes

  include Shareable

  validates :user_id, presence: true

  has_attached_file :photo,
                    path: 'collections/:id/photo.:extension',
                    default_url: '',
                    s3_region: ENV['AWS_REGION']
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :photo,
    less_than: 5.megabytes, if: :publisher_is_subscriber?
  validates_with AttachmentSizeValidator, attributes: :photo,
    less_than: 25.megabytes, if: :publisher_is_subscriber?

  def recipes
    results = user.recipes.pluck(:id, :collections)
    results.delete_if { |item| !item[1].include?(id.to_s) }
    Recipe.find(results.transpose[0] || [])
  end

  def to_param
    "#{id} #{name}".parameterize
  end

  def imaged?
    photo.url.present?
  end

  def unimaged?
    !imaged?
  end

  def photo_url
    imaged? ? photo.url : "#{ENV['SPLATTERED_URL']}/#{name}"
  end

  def public_url
    coll_share_url shared_id
  end
end

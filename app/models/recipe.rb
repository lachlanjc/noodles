class Recipe < ApplicationRecord
  belongs_to :user, touch: true

  include Shareable

  validates :title,
            presence: true,
            length: { maximum: 254 }
  validates :user_id,
            presence: true

  has_attached_file :img,
                    path: 'recipes/:id/img/:style.:extension',
                    default_url: '',
                    s3_region: ENV['AWS_REGION']
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :img, less_than: 5.megabytes

  before_update :collection_cleanup!

  def to_param
    "#{id} #{title}".parameterize
  end

  def name
    title
  end

  def description_truncated
    description.to_s.truncate(164)
  end

  def imaged?
    img.url.present?
  end

  def unimaged?
    !imaged?
  end

  def sample?
    shared_id == 'sample'
  end

  def find_collections
    list = user.collections.pluck(:id)
    list.delete_if { |item| !collections.include?(item.to_s) }
    Collection.find(list)
  end

  def photo_url
    imaged? ? img.url : "#{ENV['SPLATTERED_URL']}/#{name}"
  end

  def public_url
    share_url shared_id
  end
  
  def from_web?
    source.to_s.match(/https?/).present?
  end

  def duplicate_for(user)
    @new = dup
    @new.user_id = user.id
    @new.source = public_url
    @new.favorite = false
    @new.save
    recipe_path @new
  end

  private

  def collection_cleanup!
    collections.reject!(&:blank?)
  end
end

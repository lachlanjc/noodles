class Recipe < ActiveRecord::Base
  belongs_to :user

  include Shareable

  validates :title, presence: true, length: { maximum: 254 }
  validates :user_id, presence: true

  has_attached_file :img, default_url: '', path: 'recipes/:id/img/:style.:extension'

  validates_attachment_content_type :img, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :img, less_than: 2.megabytes

  def to_param
    "#{id} #{title}".parameterize
  end

  def description_truncated
    self.description.to_s.truncate(164)
  end
end

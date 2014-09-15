class Recipe < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image, styles: {
    thumb: '250x250>',
    img: '1024x768>'
  }
  validates :avatar,
  attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
  attachment_size: { less_than: 2.megabytes }
end

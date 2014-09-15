class Recipe < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image, styles: {
    thumb: '100x100>',
    recipe: '1024x768>',
    medium: '300x300>'
  }
  validates :avatar,
  attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
  attachment_size: { less_than: 3.megabytes }
end

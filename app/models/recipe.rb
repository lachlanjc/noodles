class Recipe < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { minimum: 4 }
  validates :user_id, presence: true

  has_attached_file :img,
    :path => 'recipes/:id/img/:style.:extension',
    :default_url => ''
  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/

  def to_param
    "#{id} #{title}".parameterize
  end

  def as_json
    {
      title: title,
      description_preview: description.truncate(165),
      favorite: favorite,
      url: "/recipes/" + id.to_s,
      shared_url: "/s/" + shared_id.to_s
    }
  end
end

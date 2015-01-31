class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :recipes

  validates :user_id, presence: true

  has_attached_file :photo,
  :path => 'collections/:id/photo.:extension',
  :default_url => ''
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def to_param
    "#{id} #{name}".parameterize
  end

  def as_json
    {
      name: name,
      description: description,
      url: '/collections/' + id.to_s,
      photo_url: photo.url.to_s
    }
  end
end

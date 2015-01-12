class Recipe < ActiveRecord::Base
  include SearchCop

  search_scope :search do
    attributes :title, :description
  end

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
end

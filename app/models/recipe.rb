class Recipe < ActiveRecord::Base
  belongs_to :user

  has_attached_file :img,
    :path => 'recipes/:id/img/:style.:extension',
    :default_url => ''
  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/

  def to_param
    "#{id} #{title}".parameterize
  end
end

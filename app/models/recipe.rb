class Recipe < ActiveRecord::Base
  belongs_to :user

  has_attached_file :img
  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/
end

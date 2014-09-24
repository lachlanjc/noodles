class Recipe < ActiveRecord::Base
  belongs_to :user

  has_attached_file :img
  validates_attachment_content_type :img, :size => { less_than: => 2.megabytes }, :content_type => /\Aimage\/.*\Z/
end

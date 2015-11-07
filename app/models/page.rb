class Page < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { maximum: 254 }
  validates :user_id, presence: true
end

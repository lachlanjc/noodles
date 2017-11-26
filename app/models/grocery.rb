class Grocery < ApplicationRecord
  belongs_to :user, touch: true

  validates :name, :user_id, presence: true

  scope :active, -> { where('completed_at IS NULL') }
  scope :past,   -> { where('completed_at IS NOT NULL').order(name: :desc) }

  def completed?
    completed_at.blank?
  end

  def incompleted?
    !completed?
  end

  def complete!
    update_attribute(:completed_at, Time.zone.now)
  end

  def incomplete!
    update_attribute(:completed_at, nil)
  end
end

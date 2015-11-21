class Page < ActiveRecord::Base
  include LibraryHelper

  belongs_to :user

  include Shareable

  validates :name, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true

  before_save :clean_page_name!
  before_save :generate_page_preview_text!

  def archived?
    archived_at.to_bool
  end

  def active?
    !archived?
  end

  protected

  def clean_page_name!
    self.name.to_s.squish!
  end

  def generate_page_preview_text!
    self.content_raw = page_preview_text(self.content)
  end
end

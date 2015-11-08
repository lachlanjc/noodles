module Shareable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_shared_id!, on: :create
    before_validation :check_shared_id
    validates :shared_id, presence: true, uniqueness: true
  end

  def generate_shared_id!
    self.shared_id = rand(32**8).to_s(32)
  end

  protected

  def check_shared_id
    self.generate_shared_id! if self.shared_id.blank?
  end
end

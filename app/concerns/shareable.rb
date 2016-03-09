# Shareable provides unique shared_ids for generating public links
module Shareable
  extend ActiveSupport::Concern

  included do
    validates :shared_id, presence: true, uniqueness: true
    before_validation :generate_shared_id, on: :create
    after_validation :generate_shared_id, on: :create, unless: proc { |recipe| recipe.errors.empty? }
  end

  private

  def generate_shared_id
    self.shared_id = rand(32**8).to_s(32)
  end
end

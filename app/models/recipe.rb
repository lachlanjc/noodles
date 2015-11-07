class Recipe < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { maximum: 254 }
  validates :user_id, presence: true
  validates :shared_id, presence: true, uniqueness: true

  before_validation :generate_shared_id, on: :create
  after_validation :generate_shared_id, on: :create, unless: Proc.new { |recipe| recipe.errors.empty? }

  has_attached_file :img,
    path: 'recipes/:id/img/:style.:extension',
    default_url: ''
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :img, less_than: 2.megabytes

  def to_param
    "#{id} #{title}".parameterize
  end

  protected

  def generate_shared_id
    self.shared_id = rand(32**8).to_s(32)
  end
end

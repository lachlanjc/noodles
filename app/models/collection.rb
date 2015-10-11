class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :recipes

  validates :user_id, presence: true
  validates :hash_id, presence: true, uniqueness: true

  before_validation :generate_hash_id, on: :create
  after_validation :generate_hash_id, on: :create, unless: Proc.new { |coll| coll.errors.empty? }

  has_attached_file :photo, path: 'collections/:id/photo.:extension', default_url: ''
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def to_param
    "#{id} #{name}".parameterize
  end

  def as_json
    {
      name: name,
      description: description,
      url: Rails.application.routes.url_helpers.collection_path(self),
      publisher: user.first_name,
      photo_url: photo.url.to_s
    }
  end

  protected
    def generate_hash_id
      self.hash_id = rand(32**8).to_s(32)
    end
end

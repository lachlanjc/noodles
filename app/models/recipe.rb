class Recipe < ActiveRecord::Base
  include SearchCop
  include MarkdownHelper

  search_scope :search do
    attributes :title, :description
  end

  belongs_to :user

  validates :title, presence: true, length: { minimum: 4 }
  validates :user_id, presence: true

  has_attached_file :img,
    :path => 'recipes/:id/img/:style.:extension',
    :default_url => ''
  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/

  def to_param
    "#{id} #{title}".parameterize
  end

  def as_json
    {
      title: title,
      description: description,
      favorite: favorite,
      url: "/recipes/" + id.to_s,
      notes: notes.to_s,
      notes_rendered: markdown(notes.to_s)
    }
  end
end

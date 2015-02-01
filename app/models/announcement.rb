class Announcement < ActiveRecord::Base
  def to_param
    "#{id} #{title}".parameterize
  end

  def as_json
    {
      title: title,
      url: "http://www.getnoodl.es/announcements/" + id.to_s,
      created_at: created_at.strftime("%B %e, %Y"),
      body_rendered: body_rendered
    }
  end
end

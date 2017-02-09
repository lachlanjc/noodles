module SocialHelper
  def social_icon(service)
    colors = {
      twitter: '#00aced',
      facebook: '#3b5998',
      pinterest: '#cb2027',
      email: '#0092ff'
    }
    inline_svg "social-#{service}.svg", size: 28, fill: colors[service.to_sym]
  end

  def social_button(object, service)
    link_to(object.send(:"#{service}_url"), target: '_blank', class: 'mrm') do
      social_icon service
    end
  end

  def social_services
    %w(twitter facebook pinterest email)
  end

  def social_buttons(object)
    html = ""
    social_services.each do |s|
      html += social_button(object, s)
    end
    html.html_safe
  end
end

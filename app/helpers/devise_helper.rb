module DeviseHelper
  def devise_error_messages!(defined_resource = nil)
    user = defined_resource || resource
    return if user.errors.empty?

    messages = user.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: user.errors.count,
                      resource: user.class.model_name.human.downcase)

    html = <<-HTML
    <div class="rounded mt2 mb2 phm mx-auto" style="border: 2px solid #ff0013; padding-bottom: 1.5rem;">
      <h2 class="red mt3 center">Those Noodles are a bit tangled.</h2>
      <ul class="list-reset pan text center">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

  def nobody_signed_in?
    !user_signed_in?
  end
end

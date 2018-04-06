module DeviseHelper
  def devise_error_messages!(defined_resource = nil)
    user = defined_resource || resource
    return if user.errors.empty?

    messages = user.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="rounded pam phm mvm mx-auto" style="border: 2px solid #ff0013; padding-bottom: 1.5rem;">
      <h2 class="red mtn f3">Those Noodles are a bit tangled.</h2>
      <ul class="list-reset pan man">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.present?
  end
end

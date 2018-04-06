class RegistrationsController < Devise::RegistrationsController
  def subscribe; end

  protected

  def after_sign_up_path_for(_resource)
    params[:explore] ? explore_path : recipes_path
  end

  def after_update_path_for(_resource)
    request.referer == groceries_url ? groceries_path : recipes_path
  end

  def update_resource(resource, params)
    return super if params[:password]&.present?
    resource.update_without_password(params.except(:current_password))
  end
end

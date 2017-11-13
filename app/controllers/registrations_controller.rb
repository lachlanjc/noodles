class RegistrationsController < Devise::RegistrationsController
  def subscribe; end

  protected

  def after_sign_up_path_for(_resource)
    params[:explore] ? explore_path : recipes_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end

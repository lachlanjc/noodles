class RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      params[:explore] ? explore_path : onboarding_path
    end
end

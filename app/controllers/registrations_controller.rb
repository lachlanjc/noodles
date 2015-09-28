class RegistrationsController < Devise::RegistrationsController
  layout :registrations_layout

  protected
    def after_sign_up_path_for(resource)
      params[:explore] ? explore_path : onboarding_path
    end

  private
    def registrations_layout
      request.xhr? == 0 ? false : 'application'
    end
end

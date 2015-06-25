class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :devise_configure_permitted_parameters, if: :devise_controller?

    protected
    def devise_configure_permitted_parameters
      devise_parameter_sanitizer.for(:accept_invitation) << :name
    end

  private

  def after_invite_path_for(resource)
    users_path
  end
end

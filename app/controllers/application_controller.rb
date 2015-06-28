class ApplicationController < ActionController::Base
  include SmartListing::Helper::ControllerExtensions
  helper SmartListing::Helper

  protect_from_forgery with: :null_session
  before_action :devise_configure_permitted_parameters, if: :devise_controller?

  def list_create(resource, param)
    resource.joinuser.like(param) if resource
  end

  def create_rev_exp(resource)
    resource.user_id = current_user.id
    if resource.save
      msg_success
      redirect_to resource
    else
      redirect_to :new
      msg_error
    end
  end

  protected

  def devise_configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) << :name
  end

  private

  def after_invite_path_for(_resource)
    users_path
  end

  def msg_success
    flash[:notice] = 'Was successfully created'
  end

  def msg_error
    flash[:notice] = 'Please try again!'
  end
end

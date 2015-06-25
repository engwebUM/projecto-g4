class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private

  def after_invite_path_for(resource)
    users_path
  end
end

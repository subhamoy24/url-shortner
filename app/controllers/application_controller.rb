class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :authenticate_user

  protected

  def authenticate_user
    return if logged_in?

    flash[:danger] = "Please log in."
    redirect_to root_path
  end
end

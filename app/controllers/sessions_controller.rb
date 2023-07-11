class SessionsController < ApplicationController
  skip_before_action :authenticate_user


  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      log_in(user)
      remember(user)
      redirect_to dashboard_path
    else
      flash[:errors] = ["Invalid email/password combination"]
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end

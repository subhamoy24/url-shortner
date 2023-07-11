class UsersController < ApplicationController
  skip_before_action :authenticate_user

  def new
    @user = User.new
  end

  def dashboard
    @url_mappers = UrlMapper.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      binding.pry
      log_in(@user)
      remember(@user)
      redirect_to dashboard_path
    else
      flash[:errors] = @user.errors.full_messages
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end
end

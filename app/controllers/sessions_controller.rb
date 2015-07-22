class SessionsController < ApplicationController
  before_action :logged_in_user, only: [:new]

  def new

  end

  def create
    @user = User.find_by_email(params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id

      redirect_to dashboard_path(session[:user_id])
    else
      flash.now[:error] = "Incorrect Username/Password Combination, Please Try Again or Sign Up as A New Vendor"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end

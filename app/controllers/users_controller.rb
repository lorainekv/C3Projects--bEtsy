class UsersController < ApplicationController
  before_action :require_login, only: [:dashboard]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params[:user])

    if @user.save
        session[:user_id] = @user.id
        redirect_to root_url
    else
      redirect_to signup_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    @user = User.find(params[:id])
    @products = @user.products
  end

  private

  def create_params
    params.permit(user: [:username, :email, :password, :password_confirmation])
  end

end

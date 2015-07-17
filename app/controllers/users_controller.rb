class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

  end

  private

  def create_params
    params.permit(user: [:username, :price, :description, :stock, :photo_url, :user_id, :product_id])
  end

end

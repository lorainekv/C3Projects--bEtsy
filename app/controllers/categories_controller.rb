class CategoriesController < ApplicationController
  before_action :require_login, only: [:new, :create]
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(create_params[:category])

    if @category.save
      redirect_to dashboard_path(session[:user_id])
    else
      render 'new'
    end
  end

  private

  def create_params
    params.permit(category:[:name])
  end
end

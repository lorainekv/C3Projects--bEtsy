class ProductsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.create(create_params[:product])
    @product.user_id = session[:user_id]

    if @product.save
        redirect_to dashboard_path(session[:user_id])
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    @product.update(create_params[:product])

    redirect_to dashboard_path(session[:user_id])
  end

  private

  def create_params
    params.permit(product: [:name, :description, :price, :stock, :photo_url, :user_id, :category_id])
  end
end

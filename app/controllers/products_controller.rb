class ProductsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update]
  before_action :set_product, only: [:show, :edit, :update]

  def index
    @products = Product.active
  end

  def show
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
    if session[:user_id] != @product.user_id
      redirect_to product_path(@product)
    end
  end

  def update
    @product.update(create_params[:product])

    redirect_to dashboard_path(session[:user_id])
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def create_params
    params.permit(product: [:name, :description, :price, :stock, :photo_url, :user_id, :status, {:category_ids => [] }])
  end
end

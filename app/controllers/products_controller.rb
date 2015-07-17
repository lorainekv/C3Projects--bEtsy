class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews

  end

  private

  def create_params
    params.permit(product: [:name, :price, :description, :stock, :photo_url, :user_id, :product_id])
  end
end

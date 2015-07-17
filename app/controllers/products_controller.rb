class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def create_params
    params.permit(product: [:name, :password_digest, :email])
  end
end

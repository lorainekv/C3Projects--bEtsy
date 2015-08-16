class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @product = Product.find(params[:product_id])
    @user = @product.user_id

    if @user == session[:user_id]
      flash[:error] = "You cannot leave a review on your own item!"
      redirect_to product_path(params[:product_id])
    end
  end

  def create
    review = Review.new(create_params[:review])

    if review.save
      redirect_to product_path(params[:product_id])
    else
      redirect_to new_product_review_path(params[:product_id])
    end
  end

  private

  def create_params
  params.permit(review: [:rating, :text_review, :product_id])
  end
end

class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create

    @review = Review.new(create_params[:review])


    if @review.save
      redirect_to product_path(params[:product_id])
    else
      redirect_to new_product_review(params[:product_id])
    end
  end

  private

  def create_params
  params.permit(review: [:rating, :text_review, :product_id])
  end


end

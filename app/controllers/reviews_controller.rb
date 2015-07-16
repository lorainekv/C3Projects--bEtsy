class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(create_params[:review])

    # if @review.save
    # else
    # end
  end

  private

  def create_params
  params.permit(review: [:rating, :text_review, :product_id])
  end


end

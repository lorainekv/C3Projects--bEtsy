require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe "POST #create" do
    context "Valid review params" do
      let (:review_params) do
        {
          review: {
            rating: 4,
            text_review: "I like turtles.",
            product_id: 5
          }
        }
      end

      it "creates a review" do
        post :create, review_params

        expect(Review.count).to eq(1)
      end # it

    end # context
  end # describe
end # rspec

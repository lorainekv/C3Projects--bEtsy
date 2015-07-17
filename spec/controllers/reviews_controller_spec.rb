require 'rails_helper'
require 'pry'
RSpec.describe ReviewsController, type: :controller do

  describe "POST #create" do
    context "Valid reviews params do" do

      let (:review_params) do
              {
                rating: 4,
                text_review: "I like turtles.",
                product_id: 1}
            end

      it "creates a review" do
              post :create, :product_id => 1, :review => review_params
              expect(Review.count).to eq(1)
        end # it
    end # context
  end # second describe
end # first describe

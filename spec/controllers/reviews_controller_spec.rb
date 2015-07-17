require 'rails_helper'
require 'pry'
RSpec.describe ReviewsController, type: :controller do

  describe "GET #new" do
    it "responds with an HTTP 200 status" do
      get :new, product_id: 1

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

  end

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

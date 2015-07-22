require 'rails_helper'
require 'pry'
RSpec.describe ReviewsController, type: :controller do

  describe "GET #new" do
    before :each do
      @product = Product.create(name: 'a', price: 10, stock: 1, user_id: 2)
    end


    it "responds with an HTTP 200 status" do
      
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

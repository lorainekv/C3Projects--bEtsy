require 'rails_helper'
require 'pry'
RSpec.describe ReviewsController, type: :controller do

  before :each do
    @product = Product.new(name: 'a', price: 10, stock: 1, user_id: 2, status: "active")
    @product.save
  end

  describe "GET #new" do

    it "responds with an HTTP 200 status" do
      get :new, :product_id => @product.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "won't let vendors review their own items" do
      session[:user_id] = 2

      get :new, :product_id => @product.id

      expect(response).to redirect_to(product_path(assigns[:product][:id]))
      expect(flash[:error]).to eq("You cannot leave a review on your own item!")
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

    context "When records are invalid" do

      let (:bad_params) do
              {
                rating: nil,
                text_review: "I like turtles.",
                product_id: 1}
      end

      it "won't create invalid review records" do
        post :create, :product_id => 1, :review => bad_params
        expect(response).to redirect_to(new_product_review_path(assigns[:review][:product_id]))
      end
    end

  end # second describe
end # first describe

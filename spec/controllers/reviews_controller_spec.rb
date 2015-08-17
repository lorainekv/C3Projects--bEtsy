require 'rails_helper'
require 'pry'
RSpec.describe ReviewsController, type: :controller do

  before :each do
    @product = create :product
  end

  describe "GET #new" do

    it "renders the new template" do
      get :new, :product_id => @product.id
      expect(response).to render_template(:new)
    end

    it "won't let vendors review their own items" do
      session[:user_id] = 1

      get :new, :product_id => @product.id

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
        end
    end

    context "When records are invalid" do
      let (:bad_params) do
              {
                rating: nil,
                text_review: "I like turtles.",
                product_id: 1}
      end

      it "won't create invalid review records" do
        post :create, :product_id => 1, :review => bad_params
        expect(response).to redirect_to(new_product_review_path)
      end
    end

  end
end

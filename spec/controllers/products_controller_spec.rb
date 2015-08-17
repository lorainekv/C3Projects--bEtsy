require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    it "loads just active products into @products" do
      product1 = create :product
      product2 =  create :product, name: "cow shades", status: "retired"

      get :index

      expect(assigns(:products)).to match_array([product1])
    end
  end

  #Since the following methods require a user to be logged in...
  before(:each) do
    @user = create :user
    session[:user_id] = @user.id
  end

  describe "GET#New" do
    it "renders the new product template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "valid params" do
      let (:params) do {product: {id: 1, name: "a name", price: 1, user_id: 1, status: "active"}}
      end
      it "creates a new Product" do
        post :create, params, :user_id => 1

        expect(Product.count).to eq @user.id
      end
    end

    context "invalid params" do
      let (:params) do {product: { id: 1, name: "some name", user_id: 1, category_id: 1 }}
      end

      it "does not persist into the database" do
        post :create, params, :user_id => 1

        expect(Product.count).to eq 0
      end

      it "renders the new action" do
        post :create, params, :user_id => 1

        expect(response).to render_template("new")
      end
    end
  end

  describe "PATCH update" do
    it "updates an existing record" do
      session[:user_id] = 1
      @product = create :product

      patch :update, id: @product.id, product: { id: 1, name: "A new name", price: 12, user_id: 1}
      @product.reload

      expect(@product.price).to eq 12
    end
  end
end

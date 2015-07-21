require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do

    it "loads all of the products into @products" do
      product1, product2 = Product.create(:name => "First Product Name", :price => 2, :user_id => 3), Product.create(:name => "2nd Product Name", :price => 5, :user_id => 4)
      get :index
      expect(assigns(:products)).to match_array([product1, product2])
    end
  end

  describe "GET#New" do
    it "saves a new blank instance of product in a variable" do
      @product = Product.new(id: 1, name: "some name", price: 1, user_id: 1)
      @product.save

      get :new
      expect(Product.count).to eq 1
    end
  end

  describe "POST #create" do
    context "valid params" do
      let (:params) do {product: {id: 1, name: "a name", price: 1, user_id: 1 }}
      end

      before :each do
        @user = User.create( id: 1, username: "someone", email: "an email is here")
      end

      it "creates a new Product" do
        post :create, params, :user_id => 1

        expect(Product.count).to eq 1
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
      @product = Product.create(id: 1, name: "some name", price: 4, user_id: 1)
      @product.save

      patch :update, id: @product.id, product: { id: 1, name: "A new name", price: 4, user_id: 1, category_id: 1 }
      @product.reload

      expect(@product.category_id).to eq 1
    end
  end
end

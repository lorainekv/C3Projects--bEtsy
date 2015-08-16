require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do

    it "loads just active products into @products" do
      product1 = Product.create(:name => "1st Product Name", :price => 2, :user_id => 3, :status => "active")
      product2 =  Product.create(:name => "2nd Product Name", :price => 5, :user_id => 4, :status => "retired")
      get :index
      expect(assigns(:products)).to match_array([product1])
    end
  end

  describe "GET#New" do
    it "saves a new blank instance of product in a variable" do
      @product = Product.new(id: 1, name: "some name", price: 1, user_id: 1, status: "active")
      @product.save

      get :new
      expect(Product.count).to eq 1
    end

    it "saves a new blank instance of review in a variable" do
      @product = Product.new(id: 7, name: "some name", price: 1, user_id: 1)
      @product.save
      @review = Review.new(rating: 1, text_review: "twas good", product_id: 7)
      @review.save
      get :new, :product_id => @product.id
      expect(@review.product_id).to eq 7
    end
  end

  describe "POST #create" do
    context "valid params" do
      let (:params) do {product: {id: 1, name: "a name", price: 1, user_id: 1, status: "active"}}
      end

      before :each do
        @user = User.create( id: 1, username: "someone", email: "an email is here")
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
      @product = Product.create(id: 1, name: "some name", price: 4, user_id: 1, status: "active")

      patch :update, id: @product.id, product: { id: 1, name: "A new name", price: 12, user_id: 1}
      @product.reload

      expect(@product.price).to eq 12
    end
  end
end

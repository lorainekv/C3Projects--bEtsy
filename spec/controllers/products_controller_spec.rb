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
    before :each do
      @product = Product.new(id: 1, name: "some name", price: 1, user_id: 1)
      @product.save
    end

    it "saves a new blank instance of product in a variable" do
      get :new
      expect(Product.count).to eq 1
    end

    it "renders a new page" do
      get :new
      expect(subject).to render_template(:new)
    end
  end

end

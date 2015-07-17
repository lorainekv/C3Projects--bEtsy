require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET new" do

    before :each do
      @product = Product.new(id: 1, name: "some name", price: 1, user_id: 1)
      @item = OrderItem.new(quantity: 2, product_id: 1)
      @product.save
    end

    it "saves a new blank instance of item in a variable" do
      get :new, :product_id => @product.id
      expect(@item.quantity).to eq 2
    end

    it "renders a new page" do
      get :new, :product_id => @product.id
      expect(subject).to render_template(:new)
    end
  end
end

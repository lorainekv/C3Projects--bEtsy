require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "renders the :index view for order items in cart" do
       get :index
       expect(response).to render_template("index")
    end
  end

  before :each do
    @product = create :product
  end

  describe "GET new" do
    it "loads the new template" do
      get :new, :product_id => @product.id
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    let (:params) do {order_item: {id: 1, quantity: 1, product_id: 1 }}
    end

    it "creates a new OrderItem" do
      post :create, params

      expect(OrderItem.count).to eq(1)
    end

  end

  describe "DELETE destroy" do
    it "deletes item from the database" do
      item = create :order_item

      delete :destroy, id: item.id

      expect(OrderItem.count).to eq 0
    end
  end
end

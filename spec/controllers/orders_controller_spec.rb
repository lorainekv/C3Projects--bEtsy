require 'rails_helper'
require 'pry'
require 'support/vcr_setup'

RSpec.describe OrdersController, type: :controller do

  describe "GET #index" do

    before(:each) do
      @order1 = create :order
      @order2 = create :order , id: 2
      @order_item1 = create :order_item, order_id: 1, shipping: "unshipped"
      @order_item2 = create :order_item, order_id: 2, shipping: "unshipped"
      @user = create :user
    end

    it "renders the :index view for a User's orders" do
      session[:user_id] = @order_item1.user_id

      get :index

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "loads all orders into @orders" do
      session[:user_id] = @order_item1.user_id

      get :index

      expect(assigns(:orders)).to match_array([@order1, @order2])
    end
  end

  describe "GET #show " do
    before(:each) do
      @order = create :order
      @item = create :order_item
      session[:order_id] = @order.id
    end

    it "allows vendors to see their orders" do
      get :show, id: @order.id, order_id: @item.order_id
      expect(assigns(:order)).to eq(@order)
    end
  end


  describe "PATCH #update" do
    before(:each) do
      @product = create :product
      @order = create :order, status: "pending", shipment_id: 1
      @item = create :order_item, order_id: @order.id, product_id: @product.id
      @shipment = create :shipment, order_id: @order.id
      session[:order_id] = @order.id
    end

    it "changes the order status to 'paid'" do
      patch :update, :id => @order.id, :checkout => {status: "paid", carrier: "UPS", delivery: "ground", delivery_date: "NONE", address: "123", city: "Alhambra", state: "CA", zipcode: 91803}
      @order.reload
      expect(@order.status).to eq("paid")
    end
  end

  describe "POST #update_shipping" do
    before(:each) do
      @order = create :order, status: "pending", shipment_id: 1
      @shipment = create :shipment, order_id: @order.id

      session[:order_id] = @order.id

      VCR.use_cassette "audit_log" do
        post :update_shipping, :id => @order.id, "shipment" => "{\"carrier\"=>\"UPS\", \"delivery\"=>\"UPS Ground\", \"delivery_date\"=>\"No delivery estimate available.\", \"shipping_cost\"=>\"14\"}"
      end
    end

    it "resets the session to nil when a transaction is complete" do
      expect(session[:order_id]).to eq(nil)
    end
  end
end

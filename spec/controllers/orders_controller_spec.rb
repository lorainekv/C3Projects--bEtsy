require 'rails_helper'
require 'pry'

RSpec.describe OrdersController, type: :controller do

  describe "GET #index" do

    before(:each) do
      @order1 = Order.create(id: 1)
      @order2 = Order.create(id: 2)
      @order_item1 = OrderItem.create(quantity: 1, order_id: 1, product_id: 1, user_id: 1, shipping: "unshipped")
      @order_item2 = OrderItem.create(quantity: 1, order_id: 2, product_id: 1, user_id: 1, shipping: "unshipped")
      @user = User.create(:username => "First Vendor Name", :email => "test@email.com", :password => "unigoat", :password_confirmation => "unigoat")
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
      @order = Order.create(id: 1)
      @item = OrderItem.create(quantity: 1, order_id: 1, product_id: 1)
      session[:order_id] = @order.id
    end

    after :each do
      @order.destroy
    end

    it "allows vendors to see their orders" do
      get :show, id: @order.id, order_id: @item.order_id
      expect(assigns(:order)).to eq(@order)
    end
  end


  describe "PATCH #update" do
    before(:each) do
      @product = Product.create(name: 'Doll', price: 10, user_id: 1, status: 'active')
      @order = Order.create(status: "pending")
      @item = OrderItem.create(quantity: 1, order_id: @order.id, product_id: @product.id)
      session[:order_id] = @order.id
    end

    after :each do
      @order.destroy
    end

    it "changes the order status to 'paid'" do
      patch :update, :id => @order.id, checkout: {status: "paid"}
      @order.reload
      expect(@order.status).to eq("paid")
    end

    it "resets the session to nil when a transaction is complete" do
      patch :update, :id => @order.id, checkout: {status: "paid"}
      expect(session[:order_id]).to eq(nil)
    end

  end


end

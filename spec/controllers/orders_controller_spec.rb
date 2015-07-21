require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  describe "GET #show " do
    # it "allows vendors to see their orders" do
    #   get :show, :order_id => 1
    #   expect(response).to be_success
    # end
  end

  describe "PATCH #update" do
    before(:each) do
      @order = Order.create(status: "pending")
      item = OrderItem.create(quantity: 1, order_id: 1, product_id: 1)
      session[:order_id] = @order.id
    end

    it "changes the order status to 'paid'" do
      patch :update, :id => session[:order_id]
      @order.reload
      expect(@order.status).to eq("paid")
    end

    it "resets the session to nil when a transaction is complete" do
      patch :update, :id => session[:order_id]
      expect(session[:order_id]).to eq(nil)
    end

  end




end

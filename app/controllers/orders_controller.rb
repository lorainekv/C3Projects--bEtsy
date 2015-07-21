class OrdersController < ApplicationController
# before_action :create_cart, only: [:create]

def new

end

# def create
#   unless session[:order_id]
#     @order = Order.create
#     session[:order_id] = @order.id
#   end
#     render cart_path
# end

def show
  render :edit
end

def update
  order = Order.find(session[:order_id])
  order.status = 'paid'
  order.save

  # Clear the session's order_id so any new items get a new order
  session[:order_id] = nil

  render '/orders/confirmation'
end

end

class OrdersController < ApplicationController

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
  @order = Order.find(session[:order_id])
  if @order.order_items.length > 0
    @order.status = 'paid'
    @order.save
    session[:order_id] = nil
    render '/orders/confirmation'
  else
    flash.now[:error] = "Order must have at least one item."
    raise
    render :edit
  end

  # Clear the session's order_id so any new items get a new order
end



end

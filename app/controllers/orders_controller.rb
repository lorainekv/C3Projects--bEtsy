class OrdersController < ApplicationController

def new

end

def index
  @orders = Order.all
end


def edit
  @order = Order.find(session[:order_id])
  render :edit
end

def show
  @order = Order.find(params[:order_id])
  render :show
end

def update
  @order = Order.find(session[:order_id])
  @order.update(create_params[:checkout])
  if @order.order_items.length > 0
    @order.status = 'paid'
    @order.save

    update_stock

    # Clear the session's order_id so any new items get a new order
    session[:order_id] = nil
    @time = Time.now.localtime


    render '/orders/confirmation'

  else
    flash.now[:error] = "Order must have at least one item."
    render :edit
  end
end

private

def create_params
  params.permit(checkout: [:name, :email, :address, :cc4, :expiry_date])
end

end

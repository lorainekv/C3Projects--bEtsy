class OrdersController < ApplicationController
# before_action :create_cart, only: [:create]

def new

end

def create
  unless session[:order_id]
    @order = Order.create
    session[:order_id] = @order.id
  end
    render cart_path
end


def edit
  @order = Order.find(params[:id])

  render :edit
end

end

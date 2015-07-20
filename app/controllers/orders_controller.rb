class OrdersController < ApplicationController

def new
  
end

def edit
  @order = Order.find(params[:id])

  render :edit
end

end

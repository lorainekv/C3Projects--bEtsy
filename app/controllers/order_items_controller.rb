class OrderItemsController < ApplicationController


  def index
    @order_items = OrderItem.joins(:order).where('orders.status' => 'pending').where('orders.id' => session[:order_id])
  end

  def new
    @item = OrderItem.new
    @product = Product.find(params[:product_id])
    @merchant = Product.find(params[:product_id]).user_id
    @stock = @product.stock
    if @stock == 0
      flash.now[:error] = "We're Sorry, This Item is Currently Sold Out!"
    end
  end

  def create
    @item = OrderItem.create(create_params[:order_item])

    # If we don't have an order_id in the session, create one
    unless session[:order_id]
      new_order
    end

    # Update the item with the order_id
    @item.order_id = session[:order_id]
    @item.save

    redirect_to cart_path
  end

  def edit
    @order_item = OrderItem.find(params[:id])
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.shipping = "Yes"
    @order_item.save
    order_complete
    redirect_to dashboard_orders_path
  end

  def destroy
    @item = OrderItem.find(params[:id])
    @item.destroy
    redirect_to cart_path
  end

  private

  def create_params
    params.permit(order_item: [:quantity, :order_id, :product_id, :user_id, :shipping])
  end

end

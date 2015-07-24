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
    @product = Product.find(params[:order_item][:product_id])

    increase_by = params[:order_item][:quantity].to_i
    existing_cart = session[:order_id]
    current_product_id = params[:order_item][:product_id]
    current_order_item = OrderItem.where(product_id: current_product_id , order_id: existing_cart)

    if current_order_item.present?
      raise "extra carts found" if current_order_item.count > 1
      @item = current_order_item.first
      @before_quantity = @item.quantity

      if @before_quantity >= @product.stock
        flash.now[:error] = "We're Sorry, This Item is Out of Stock"
        render 'new'
        return
      else
        if @before_quantity + increase_by > @product.stock
          flash.now[:error] = "There aren't enough left!"
          render 'new'
          return
        else
          @item.quantity += increase_by
        end
      end

    else
      @item = OrderItem.create(create_params[:order_item])

    end
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

  def quantity_update
    @order_item = OrderItem.find(params[:order_item][:id])
    @order_item.quantity = params[:order_item][:quantity]
    @order_item.save

    @product = Product.find(@order_item.product_id)
    @stock = @product.stock
    if @order_item.quantity > @stock
      flash.now[:error] = "We don't have that many in stock!"
    render "products/show"
    return
    end
    redirect_to cart_path
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

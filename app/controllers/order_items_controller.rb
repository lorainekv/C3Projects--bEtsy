require 'httparty'

class OrderItemsController < ApplicationController
  before_action :find_order_item, only: [:edit, :quantity_update, :update, :destroy]

  SHIP_EST_UPS = Rails.env.production? ? "http://adaships.herokuapp.com/estimate/ups" : "http://localhost:3001/estimate/ups"
  SHIP_EST_USPS = Rails.env.production? ? "http://adaships.herokuapp.com/estimate/usps" : "http://localhost:3001/estimate/usps"

  def index
    @order_items = OrderItem.joins(:order).where('orders.status' => 'pending').where('orders.id' => session[:order_id])
    @order = Order.find(session[:order_id])
  end

  def new
    @item = OrderItem.new
    @product = Product.find(params[:product_id])
    @merchant = @product.user_id
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
      # line b is probably the extra unecessary code
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

  def ship_est
    @order_items = OrderItem.joins(:order).where('orders.status' => 'pending').where('orders.id' => session[:order_id])
    @order = Order.find(session[:order_id])
    item_quantity = @order_items.count
    # In our world, each item weighs 10 oz. :)
    weight = item_quantity * 10
    if params[:ups]
      @ups_estimate = HTTParty.get(SHIP_EST_UPS + "/#{params[:zipcode]}/#{weight}")
    end
    if params[:usps]
      @usps_estimate = HTTParty.get(SHIP_EST_USPS + "/#{params[:zipcode]}/#{weight}")
    end
    render "index"
  end

  def edit
    @order_item
  end

  def quantity_update
    @order_item
    @product = Product.find(@order_item.product_id)
    @stock = @product.stock

    if params[:order_item][:quantity].to_i > @stock
      flash.now[:error] = "We don't have that many in stock!"
      render "products/show"
      return
    else
      @order_item.quantity = params[:order_item][:quantity]
      @order_item.save
      redirect_to cart_path
    end
  end

  def update
    @order_item.shipping = "Yes"
    @order_item.save
    order_complete
    redirect_to dashboard_orders_path
  end

  def destroy
    @order_item
    @order_item.destroy
    redirect_to cart_path
  end

  def find_order_item
     @order_item = OrderItem.find(params[:id])
  end

  private

  def new_order
    # unless session[:order_id]
      @order = Order.create
      @order.status = "pending"
      session[:order_id] = @order.id
    # end
  end

private

  def order_complete
    @order_item = OrderItem.find(params[:id])
    order_id = @order_item[:order_id]
    @order_items = OrderItem.where("order_id = ?", order_id)
    @order = Order.find(order_id)

    all_items = @order_items.length

    counter = 0

    @order_items.each do |item|
      if item.shipping == "Yes"
        counter += 1
      end
    end

    if counter == all_items
      @order.status = "Complete"
      @order.save
    end
  end

  def create_params
    params.permit(order_item: [:quantity, :order_id, :product_id, :user_id, :shipping])
  end

end

require 'httparty'

class OrdersController < ApplicationController
    before_action :order_page_access, only: [:index]
    before_action :find_order, only: [:edit, :show, :update]

  def index
    @merchant = session[:user_id]
    @orders = Order.includes(:order_items).where(order_items: { user_id: @merchant } )
    # @order_item = OrderItem.find(params[:id])

    if params[:status] == "paid"
      @orders = @orders.where("status = ?", "paid")
    elsif params[:status] == "complete"
      @orders = @orders.where("status = ?", "Complete")
    end
    render :index
  end


  def edit
    render :edit
  end

  def show
    render :show
  end

  def update
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

  def find_order
    @order = Order.find(session[:order_id])
  end
  def review
    raise

    # Order.order_items.each |item| do
      # User.find(item.user.id)city, state, zipcode = origin
      # Product.find(item.product_id).weight, dimensions = packages
      #destination info in order/checkout form

      # how to we match packages with users(nesting?)
    # end
  end

  private

  def order_complete
    @order_item = OrderItem.find(params[:id])
    order_id = order_item[:order_id]
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
  

  # def shipping_rates
  # end


  def create_params
    params.permit(destination: [:name, :email, :address, :cc4, :expiry_date])
  end

end

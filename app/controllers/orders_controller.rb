require 'httparty'

class OrdersController < ApplicationController
    before_action :order_page_access, only: [:index]
    before_action :find_order, only: [:edit, :show, :update, :review]

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
    review
    
    @order.update(create_params[:destination])


    if @order.order_items.length >= 10
      dimensions = [8,8,8]
      weight  = 5
      @order.status = 'paid'
      @order.save

      update_stock

      # Clear the session's order_id so any new items get a new order
      session[:order_id] = nil
      @time = Time.now.localtime

      return '/orders/confirmation'
    elsif @order.order_items.length <= 9 && !0
      dimensions = [2,2,2]
      weight  = 3
      @order.status = 'paid'
      @order.save

      update_stock

      # Clear the session's order_id so any new items get a new order
      session[:order_id] = nil
      @time = Time.now.localtime

      return  '/orders/confirmation'
    elsif @order.order_items.length == 0
      flash.now[:error] = "Order must have at least one item."
      render :edit
    end
  end
  

  def find_order
    @order = Order.find(session[:order_id])
  end
  
  def review
    shipment = {}
    origin = []
    destination = []
    packages = []

     o = @order.order_items.first 
     z = User.find(o.user_id)
      
      origin << z.city
      
      origin << z.state
      
      origin << z.zipcode
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
  



  def create_params
    params.permit(destination: [:name, :email, :address, :cc4, :expiry_date, :city, :state, :zipcode])
  end
  
end

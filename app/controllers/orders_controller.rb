require 'httparty'

class OrdersController < ApplicationController
    before_action :order_page_access, only: [:index]
    before_action :find_order, only: [:edit, :show, :update, :review]

    # dev shipping api uri
    DEV_SHIPPING_BASE_URI = "http://localhost:3001/shipments/"

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

  def shipping_rates
    shipment = {
      shipment: {
        origin: {
          name: "Petsy Inc",
          address1: "3320 James Rd",
          country: "US",
          city: "Keuka Park",
          state: "NY",
          postal_code: "14478"
        },
        destination: {
          name: "Ms. Customer",
          address1: "4040 26th Ave SW",
          country: "US",
          city: "Seattle",
          state: "WA",
          postal_code: "98106"
        },
        packages: {
          weight: 4,
          dimensions: [12, 12, 12]
        }
      }
    }

    json_shipment = shipment.to_json

    response = HTTParty.get(DEV_SHIPPING_BASE_URI, query: { json_data: json_shipment })
    @rates = response
    session[:shipping_option]
    # raise
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

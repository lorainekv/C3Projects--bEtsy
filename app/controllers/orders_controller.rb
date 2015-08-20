require 'httparty'

class OrdersController < ApplicationController
    before_action :order_page_access, only: [:index]
    before_action :find_order, only: [:edit, :show, :update]

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

  def shipping_rates
    shipment = {
      shipment: {
        origin: {
          country: "US",
          city: "Seattle",
          state: "WA",
          postal_code: "98106"
        },
        destination: {
          country: "US",
          city: "Minneapolis",
          state: "MN",
          postal_code: "55414"
        },
        packages: {
          weight: 2,
          dimensions: [2, 2, 2]
        }
      }
    }
    # shipment = { "shipment" => {
    #   [{"origin" => {
    #     "country" => "US", "city" => "Seattle", "state" => "WA", "zipcode" => "98104"
    #       },
    #   "destination" => {
    #       "country" => "US", "city" => "Minneapolis", "state" => "MN", "zipcode" => "55414"
    #       },
    #   "packages" => [
    #       {
    #         "weight" => "2", "dimensions" => "[2, 2, 2]"
    #       }
    #     ]}
    #   ]}}

    json_shipment = shipment.to_json

    response = HTTParty.get(DEV_SHIPPING_BASE_URI, query: { json_data: json_shipment })
    @rates = response
    raise
  end

  private

  def create_location(order)
    location = {}
    location["state"] = order.state
    location["city"] = order.city
    location["zipcode"] = order.zip
    return location
  end

  def create_package(item)
    package = {}
    product = item.product
    package["weight"] = product.weight
    package["dimensions"] = product.dimensions
    return package
  end

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
    params.permit(checkout: [:name, :email, :address, :cc4, :expiry_date])
  end

end

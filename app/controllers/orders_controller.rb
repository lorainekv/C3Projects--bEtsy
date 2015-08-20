class OrdersController < ApplicationController
  before_action :order_page_access, only: [:index]
  before_action :find_order, only: [:edit, :show, :update, :shipping, :update_shipping]

  SHIP_URI = Rails.env.production? ? "later" : "http://localhost:3001/ship"

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
    shipment = Shipment.new(create_shipment_params[:checkout])
    shipment.order_id = @order.id
    shipment.save

    @order.update(update_order_params[:checkout])

    if @order.order_items.length > 0
      @order.status = 'paid'
      @order.save

      update_stock

      redirect_to shipping_path(@order)
    else
      flash.now[:error] = "Order must have at least one item."
      render :edit
    end
  end

  def shipping
    # get all shipping options by quering our api
    shipment = @order.shipment
    all_shipment_options = HTTParty.post(SHIP_URI,
                        :body => { "address1": "#{@order.address}",
                                       "city":    "#{shipment.city}",
                                       "state":   "#{shipment.state}",
                                       "zip":     "#{shipment.zipcode}",
                                       "country": "#{shipment.country}" }.to_json,
                        :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'} )

    ups_options = all_shipment_options["ups"]["rates"]
    @ups_formatted_options = format_ups_options(ups_options)

    usps_options = all_shipment_options["usps"]["rates"]
    @usps_formatted_options = format_usps_options(usps_options)
  end

  def update_shipping
    shipment = @order.shipment
    shipment.update(eval(update_shipment_params["shipment"]))

    # Clear the session's order_id so any new items get a new order
    session[:order_id] = nil
    @time = Time.now.localtime

    render 'confirmation'
  end

  def find_order
    @order = Order.find(session[:order_id])
  end

  private

  def cents_to_dollars(cents)
    cents / 100.0
  end

  def update_order_params
    params.permit(checkout: [:name, :email, :address, :zipcode, :cc4, :expiry_date])
  end

  def create_shipment_params
    params.permit(checkout: [:address, :address2, :city, :state, :zipcode])
  end

  def update_shipment_params
    params.permit(:shipment)
  end

  def format_ups_options(shipment_options)
    formatted_options = []

    shipment_options.each do |option|
      params_hash = {}
      params_hash[:carrier] = "ups"
      params_hash[:delivery] = option["service_name"]
      params_hash[:shipping_cost] = cents_to_dollars(option["total_price"])
      formatted_options.push(params_hash)
    end

    return formatted_options
  end

  def format_usps_options(shipment_options)
    formatted_options = []

    shipment_options.each do |option|
      params_hash = {}
      params_hash[:carrier] = "usps"
      params_hash[:delivery] = option["service_name"]
      params_hash[:shipping_cost] = cents_to_dollars(option["package_rates"].last["rate"])
      formatted_options.push(params_hash)
    end

    return formatted_options
  end
end

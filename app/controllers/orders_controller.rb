class OrdersController < ApplicationController
  before_action :order_page_access, only: [:index]
  before_action :find_order, only: [:edit, :show, :update, :shipping, :update_shipping]

  SHIP_URI = Rails.env.production? ? "https://adaships.herokuapp.com/ship" : "http://localhost:3001/ship"
  LOG_URI = Rails.env.production? ? "https://adaships.herokuapp.com/log" : "http://localhost:3001/log"

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
    if shipment.save
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
    else
      flash.now[:error] = shipment.errors.messages.values.flatten[0]
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

    @ups_options = all_shipment_options["ups"]
    @usps_options = all_shipment_options["usps"]
  end

  def update_shipping
    shipment = @order.shipment

    params["shipment"] = eval(params["shipment"])
    params["shipment"].delete("delivery_date")

    params[:shipment] = params["shipment"].symbolize_keys
    shipment.update(params[:shipment].symbolize_keys)

    total(@order)

    log = HTTParty.post(LOG_URI, :body => {
      "carrier": "#{shipment.carrier}",
      "delivery_service": "#{shipment.delivery}",
      "shipping_cost": "#{shipment.shipping_cost}",
      "order_total": "#{@order.total}",
      "order_id": "#{@order.id}"
    }.to_json,
    :headers => {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    } )

    if log.response.code == "201"
      # Clear the session's order_id so any new items get a new order
      session[:order_id] = nil
      @time = Time.now.localtime

      render 'confirmation'
    else
      redirect_to cart_path(session[:order_id]), flash: { error: MESSAGES[:log_failed] }
    end
  end

  def find_order
    @order = Order.find(session[:order_id])
  end

  private

  def update_order_params
    params.permit(checkout: [:name, :email, :address, :zipcode, :cc4, :expiry_date])
  end

  def create_shipment_params
    params.permit(checkout: [:address, :address2, :city, :state, :zipcode])
  end

  def update_shipment_params
    params.permit(:carrier, :delivery, :shipping_cost)
  end

  def total(order)
    subtotal = 0

    order.order_items.each do |order_item|
      subtotal += order_item.quantity * order_item.product.price
    end

    order.total = order.shipment.shipping_cost + subtotal
    order.save
  end
end

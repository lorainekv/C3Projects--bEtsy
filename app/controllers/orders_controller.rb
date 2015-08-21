require 'httparty'

class OrdersController < ApplicationController
    before_action :order_page_access, only: [:index]
    before_action :find_order, only: [:edit, :show, :update, :review,:shipping_rates]

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
    
    if @order.order_items.length > 0
        
      @order.status = 'paid'
      @order.save  

      update_stock
        
      # Clear the session's order_id so any new items get a new order

      session[:order_id] = nil
      @time = Time.now.localtime


      render 'orders/confirmation'
    else
      flash.now[:error] = "Order must have at least one item."
      render :edit
    end

  end



  def find_order
    @order = Order.find(session[:order_id])
  end

 

  def shipping_rates
    @order.update(create_params[:destination])
    @order.save
    
    shipment = {
      shipment: {
        origin: {
          address1: "3320 James Rd",
          country: "US",
          city: "Keuka Park",
          state: "NY",
          postal_code: "14478"
        },
        destination: {
          address1: params[:destination][:address],
          country: "US",
          city: params[:destination][:city],
          state: params[:destination][:state],
          postal_code: params[:destination][:zipcode]
        },
        packages: {
          weight: 5,
          dimensions: [12, 12, 6]
        }
      }
    }

      # pass shipment object to API
      json_shipment = shipment.to_json

      response = HTTParty.get(DEV_SHIPPING_BASE_URI, query: { json_data: json_shipment })
      @rates = response
    # raise
  end

  private

  def order_complete
    @order = Order.find(params[:destination][:order_id])
    @order_items = OrderItem.where("order_id = ?", @order.id)


    # @order_item = OrderItem.find(params[:id])
    # order_id = order_item[:order_id]
    # @order_items = OrderItem.where("order_id = ?", order_id)
    # @order = Order.find(order_id)

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

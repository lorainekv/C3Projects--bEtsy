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
    @order
    render :edit
  end

  def show
    render :show
  end

  def update
    @order
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

  private

  def create_params
    params.permit(checkout: [:name, :email, :address, :cc4, :expiry_date])
  end

  end

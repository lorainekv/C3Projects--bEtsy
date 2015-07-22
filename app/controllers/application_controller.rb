class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  MESSAGES = {not_logged_in: "You are not currently logged in!"}

  def require_login
    redirect_to login_path, flash: {error: MESSAGES[:not_logged_in]} unless session[:user_id]
  end

  def new_order
    unless session[:order_id]
      @order = Order.create
      @order.status = "pending"
      session[:order_id] = @order.id

    end
  end

  def update_stock

    @order = Order.find(session[:order_id])

    @order.order_items.each do |item|
      quantity = item.quantity
      # looking for the corresponding product
      right_product = Product.find(item.product_id)

      right_product.stock -= quantity

      right_product.save

      # for each order, get the quantity tied to each item
      # look up its corresponding products
      # decrease the product stock
      # save updated product

    end
  end

end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  MESSAGES = {not_logged_in: "You are not currently logged in!",
              already_logged_in: "Can't access login page because you're already logged in!",
              already_signed_up: "You're already registered with Petcessories!",
              log_failed: "Sorry, your order could not be completed. Please call Petcessories at 1-800-LOVE-PET*. (*This is a fake number.)"
  }

  def require_login
    redirect_to login_path, flash: {error: MESSAGES[:not_logged_in]} unless session[:user_id]
  end

  def logged_in_user
    redirect_to dashboard_path(session[:user_id]), flash: {error: MESSAGES[:already_logged_in]} if session[:user_id]
  end

  def registered_user
    redirect_to dashboard_path(session[:user_id]), flash: {error: MESSAGES[:already_signed_up]} if session[:user_id]
  end

  def order_page_access
    redirect_to root_path unless session[:user_id]
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

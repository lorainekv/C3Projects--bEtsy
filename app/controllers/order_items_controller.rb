class OrderItemsController < ApplicationController

  def index
    @order_items = OrderItem.all
  end


  def new
    #takes product id and uses it to create new item w/ that product_id
    #on product show page, a link_to add a new order item
    #that takes product id and shows create form, with quantity
    #that form creates new order_item


  end

  def create


  end


end

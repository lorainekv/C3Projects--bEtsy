class WelcomeController < ApplicationController
  def index
    @products = Product.active
  end

end

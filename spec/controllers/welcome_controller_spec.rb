require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

it "loads all active products into @product" do
  product1 = Product.create(:name => "1st Product Name", :price => 2, :user_id => 3, :status => "active")
  product2 =  Product.create(:name => "2nd Product Name", :price => 5, :user_id => 4, :status => "retired")
  get :index

  expect(assigns(:products)).to match_array([product1])

end


end

require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  it "loads all active products into @product" do
    product1 = create :product
    product2 =  create :product, :name => "2nd Product Name", status: "retired"
    get :index

    expect(assigns(:products)).to match_array([product1])

  end
end

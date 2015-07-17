require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "GET index" do
    it "renders the :index view for all categories" do
       get :index
       expect(response).to render_template("index")
    end

    it "loads a category into @category" do
      category1 = Category.create(:name => "First Category Name")
      get :index
      expect(assigns(:categories)).to eq([category1])
    end
  end


end

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "GET index" do
    it "renders the :index view for all categories" do
       get :index
       expect(response).to render_template("index")
    end

    it "loads all categories into @categories" do
      category1, category2 = Category.create(:name => "First Category Name"), Category.create(:name => "2nd Category Name")
      get :index
      expect(assigns(:categories)).to match_array([category1, category2])
    end
  end

  describe "GET #show" do
    it "renders the :show view for each category" do
       get :show
       expect(response).to render_template("show")
    end

    it "loads a category into @category" do
      category1 = Category.create(:name => "First Category Name")
      get :show
      expect(assigns(:categories)).to eq([category1])
    end

  end


end

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
    before(:each) do
      @category = Category.create(:name => "First Category Name")
    end

    after :each do
      @category.destroy
    end

    it "returns http success" do
      get :show, :id => 1
      expect(response).to have_http_status(:success)
    end

    it "loads a category into @category" do
      get :show, :id => 1
      expect(assigns(:category)).to eq(@category)
    end
  end

  describe "GET#New" do
    it "saves a new blank instance of a category in a variable" do
      @category = Category.new(id: 1, name: "a new category")
      @category.save

      get :new
      expect(Category.count).to eq 1
    end
  end

  describe "POST #create" do
      let (:params) do { category: { id: 1, name: "a new category" }}
      end

      it "creates a new category" do
        session[:user_id] = 1
        post :create, params

        expect(Category.count).to eq 1
      end
    end
end

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "GET index" do
    it "renders the :index view for all categories" do
       get :index
       expect(response).to render_template("index")
    end

    it "loads all categories into @categories" do
      category1 = create :category
      category2 = create :category, name: "Hogs in Clogs"

      get :index
      expect(assigns(:categories)).to match_array([category1, category2])
    end
  end

  describe "GET #show" do
    before(:each) do
      @category = create :category
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

  #Since the following methods require a user to be logged in...
  before(:each) do
    @user = create :user
    session[:user_id] = @user.id
  end

  describe "GET#New" do
    it "renders the new form" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
      let (:params) do { category: { id: 1, name: "a new category" }}
      end

      it "creates a new category" do
        post :create, params

        expect(Category.count).to eq 1
      end
    end
end

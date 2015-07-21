require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    @user1 = User.create(:username => "First Vendor Name", :email => "test@email.com", :password => "unigoat", :password_confirmation => "unigoat")
    @user2 = User.create(:username => "Second Vendor Name", :email => "test2@email.com", :password => "unigoatess", :password_confirmation => "unigoatess")
  end

  describe "GET index" do
    it "renders the :index view for all Vendors" do
       get :index
       expect(response).to render_template("index")
    end

    it "loads all Vendors into @users" do
      get :index
      expect(assigns(:users)).to match_array([@user1, @user2])

    end
  end



  describe "GET #show" do

    it "returns http success" do
      get :show, :id => 1
      expect(response).to have_http_status(:success)
    end

    it "loads a user into @user" do
      get :show, :id => 1
      expect(assigns(:user)).to eq(@user1)
    end
  end

  describe "dashboard access" do
    context "when a user is signed in" do
      it "redirects to the dashboard" do
        session[:user_id] = @user1.id

        get :dashboard, :id => @user1.id

        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    context "when no one is signed in" do
      it "prevents dashboard from loading" do

        get :dashboard, :id => @user1.id
        expect(flash[:error]).to eq("You are not currently logged in!")
        expect(response).to redirect_to("/login")
      end
    end
  end
end

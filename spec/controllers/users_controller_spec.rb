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

  describe "GET #new" do

    it "responds with an HTTP 200 status" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

  end

  describe "POST #create" do
    context "with valid user params" do

      let (:user_params) do
        {
          username: "Stimpy",
          email: "whamo@whamo.com",
          password: "log",
          password_confirmation: "log"}
      end

      it "creates a new user" do
        post :create, :user => user_params
        expect(User.count).to eq(3) #Since two test records already exist
      end
    end

    context "with invalid user params" do
      let (:yuck_user) do
        {
          username: "Eeeediot",
          email: "whamo@whamo.com",
          password: "log",
          password_confirmation: "song"}
      end

      it "doesn't create a new user" do
        post :create, :user => yuck_user
        expect(response).to redirect_to(signup_path)
      end
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

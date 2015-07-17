require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET index" do
    it "renders the :index view for all Vendors" do
       get :index
       expect(response).to render_template("index")
    end

    it "loads all Vendors into @users" do
      user1, user2 = User.create(:username => "First Vendor Name", :email => "test@email.com", :password_digest => "password"), User.create(:username => "2nd Vendor Name", :email => "vendor@goat.com",:password_digest => "otherpassword")
      get :index
      expect(assigns(:users)).to match_array([user1, user2])

    end
  end

  describe "GET #show" do
    before(:each) do
      @user = User.create(:username => "First Vendor Name", :email => "test@email.com", :password_digest => "password")
    end

    after :each do
      @user.destroy
    end

    it "returns http success" do
      get :show, :id => 1
      expect(response).to have_http_status(:success)
    end

    it "loads a user into @user" do
      get :show, :id => 1
      expect(assigns(:user)).to eq(@user)
    end
  end


end

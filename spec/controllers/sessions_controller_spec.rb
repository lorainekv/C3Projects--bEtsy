require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:each) do
    @user = User.create(username: "unigoat", email: "unigoat@unigoat.edu", password: "unigoat", password_confirmation: "unigoat")
  end

  describe "POST #create" do

    let (:session_params) do
            {
              email: "unigoat@unigoat.edu",
              password: "unigoat"}
          end

    it "creates an authenticated session" do
      @user = User.create(username: "unigoat", email: "unigoat@unigoat.edu", password: "unigoat", password_confirmation: "unigoat")
      post :create, :session => session_params

      expect(session[:user_id]).to eq(1)
      end
  end

  describe "DELETE #destroy" do
    it "allows user to log out" do
      session[:user_id] = @user.id
      delete :destroy
      expect(session[:user_id]).to eq(nil)
    end
  end
end

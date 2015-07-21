require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

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

end

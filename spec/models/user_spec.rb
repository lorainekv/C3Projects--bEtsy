require 'rails_helper'

RSpec.describe User, type: :model do
  it "Requires that a username must be present" do
      user = User.new

      expect(user).to_not be_valid
      expect(user.errors.keys).to include(:username)
  end


  it "Requires that a email must be present" do
      user = User.new

      expect(user).to_not be_valid
      expect(user.errors.keys).to include(:email)
  end

  before do
    @user = User.create(username: "moo", email: "goats@coats.com", password: "unigoats")
    @other_user = @user.dup
    @other_user.save
  end

  it "requires that a username be unique" do
    expect(@other_user).to_not be_valid
    expect(@other_user.errors[:username]).to include("has already been taken")
  end

  it "requires that a email be unique" do
    expect(@other_user).to_not be_valid
      expect(@other_user.errors[:email]).to include("has already been taken")
  end

  it "requires an email to contain an ampersand and '.com'" do
    bad_email = User.create(username: "moo", email: "goatscoatscom", password: "unigoats")
    expect(bad_email).to_not be_valid
  end

  it "Expects if passwords to not match the user is not valid" do
    bad_pw = User.create(username: "moo", email: "goats@coats.com", password: "unigoats", password_confirmation: "unigoatsss")
    expect(bad_pw).to_not be_valid
  end
end

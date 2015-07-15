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

end

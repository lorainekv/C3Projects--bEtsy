require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "model validations" do
    it "requires rating to be an integer" do
      review = Review.new(rating: "a string")
      expect(review).to_not be_valid
    end

  end
end

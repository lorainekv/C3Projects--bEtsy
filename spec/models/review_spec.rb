require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "model validations" do
    it "requires a rating" do
      review = Review.new
      expect(review).to_not be_valid
      expect(review.errors.keys).to include(:rating)
    end

    it "rating must be an integer" do
      review = Review.new(rating: "")
      expect(review).to_not be_valid
      expect(review.errors.keys).to include(:rating)
    end

    it "requires rating to be between 1 - 5" do
      review = Review.new(rating: 5)
      expect(review).to be_valid
    end
  end
end

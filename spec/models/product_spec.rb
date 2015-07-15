require 'rails_helper'

RSpec.describe Product, type: :model do

  it "Requires that a product name be present" do
      product = Product.create

      expect(product).to_not be_valid
      expect(product.errors.keys).to include(:name)
  end

  before do
    @product = Product.create(name: "fancy cat fedora")
    @other_product = @product.dup
    @other_product.save
  end

  it "requires that a product name be unique" do
    expect(@other_product).to_not be_valid
    expect(@other_product.errors[:name]).to include("has already been taken")
  end

  it "expects a price to be present" do
  end

end

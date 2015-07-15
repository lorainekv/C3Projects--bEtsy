require 'rails_helper'

RSpec.describe Product, type: :model do

  it "Requires that a product name be present" do
      product = Product.create
      expect(product).to_not be_valid
      expect(product.errors.keys).to include(:name)
  end

  it "requires that a product name be unique" do
    product = Product.create(name: "fancy cat fedora", price:1.5, user_id: 2)
    other_product = product.dup
    other_product.save
    expect(other_product).to_not be_valid
    expect(other_product.errors[:name]).to include("has already been taken")
  end

  it "requires that the price is present" do
    product=Product.new
    expect(product).to_not be_valid
    expect(product.errors.keys).to include(:price)
  end

  it "expects a price to be a number" do
    bad_price = Product.create(price: "b")
    expect(bad_price).to_not be_valid
  end

  it "expects price to be greater than zero" do
    product=Product.new(name: "goat poncho", price: -5, user_id: 1)
    expect(product).to_not be_valid
  end

  it "requires that a product must belong to a user" do
    product=Product.new(name: "kitten mittens", price: 3)
    expect(product).to_not be_valid
  end

end

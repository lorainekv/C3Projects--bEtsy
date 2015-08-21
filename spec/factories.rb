FactoryGirl.define do  factory :shipment do
    
  end


  factory :category do
    name "Goats in Smoking Jackets"
  end

  factory :product do
    name "Goat monocle"
    price "1000"
    description "baaaaaa"
    stock 10
    user_id 1
    status "active"
  end

  factory :order_item do
    quantity 10
    order_id 1
    product_id 1
    user_id 1
  end

  factory :order do
    name "jen"
    email "jen@jen.com"
    address "111 Street Name"
    cc4 3949
  end

  factory :user do
    username "moo"
    email "moo@moo.moo"
    password "moo"
    password_confirmation "moo"
  end

end

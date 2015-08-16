FactoryGirl.define do

  factory :category do
    name "Goats in Smoking Jackets"
  end

  factory :user do
    username "moo"
    email "moo@moo.moo"
    password "moo"
    password_confirmation "moo"
  end

end

FactoryGirl.define do
  factory :product do
    title { Faker::Commerce.product_name }
    price { rand() * 100 }
    published false
    user
  end
end
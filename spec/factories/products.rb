FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 10.0..100.0) }
    stock { rand(1..50) }
  end
end

FactoryBot.define do
  factory :order do
    association :user
    association :product
    quantity { rand(1..5) }
  end
end

FactoryBot.define do
  factory :cart_item do
    quantity { rand(1..999) }

    trait :for_cart_and_dish do
      association :cart, factory: :cart
      association :dish, factory: :dish
    end
  end
end

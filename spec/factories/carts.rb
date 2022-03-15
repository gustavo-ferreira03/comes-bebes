FactoryBot.define do
  factory :cart do
    discount { rand(0..1) }

    trait :for_user_and_restaurant do
      association :user, factory: :user
      association :restaurant, factory: :restaurant
    end
  end
end

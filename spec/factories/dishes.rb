FactoryBot.define do
  factory :dish do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    value { rand(0.01..9999.99) }
    serving { rand(0..2) }
    stock { rand(0.999) }

    trait :for_restaurant do
      association :restaurant, factory: :restaurant
    end
  end
end

FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    number { rand(0..99) }
    complement { "apt 102" }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { "#{rand(10000..99999)}-#{rand(100..999)}" }
    
    trait :for_user do
      association :addressable, factory: :user
    end
    trait :for_restaurant do
      association :addressable, factory: :restaurant
    end
  end
end

FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.name }
    cnpj { "#{rand(10..99)}.#{rand(100..999)}.#{rand(100..999)}/#{rand(1000..9999)}-#{rand(10..99)}" }
    restaurant_type { rand(0..3) }

    trait :for_user do
      association :user, factory: :user
    end
  end
end

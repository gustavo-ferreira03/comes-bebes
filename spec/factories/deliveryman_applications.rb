FactoryBot.define do
  factory :deliveryman_application do
    cnh { "#{rand(10000000000..99999999999)}" }
    vehicle_type { rand(0..1) }
    status { 0 }

    trait :for_user do
      association :user, factory: :user, user_type: 1
    end
  end
end

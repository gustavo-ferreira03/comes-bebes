FactoryBot.define do
  factory :cart do
    discount { rand(0..1) }

    trait :for_user do
      association :user, factory: :user
    end
  end
end

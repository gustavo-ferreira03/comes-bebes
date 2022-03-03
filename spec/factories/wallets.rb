FactoryBot.define do
  factory :wallet do
    balance { rand(0.00..99999.99)}

    trait :for_user do
      association :user, factory: :user
    end
  end
end

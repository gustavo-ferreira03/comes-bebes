FactoryBot.define do
  factory :wallet do
    balance { rand(0.00..99999.99)}
    association :user, factory: :user
  end
end

FactoryBot.define do
  factory :image do
    image_link { Faker::Internet.url }
  
    trait :for_dish do
      association :imageable, factory: :dish
    end
    trait :for_restaurant do
      association :imageable, factory: :restaurant
    end
  end
end

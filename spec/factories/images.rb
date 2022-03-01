FactoryBot.define do
  factory :image do
    image_link { 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.mandysam.com%2Fimg%2Frandom.jpg&f=1&nofb=1' }
  
    trait :for_dish do
      association :imageable, factory: :dish
    end
    trait :for_restaurant do
      association :imageable, factory: :restaurant
    end
  end
end

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email}
    birthdate { Faker::Date.between(from: '1960-01-01', to: Date.today) }
    password { "ksdaojdawoin" }
    phone { "(#{rand(10..99)})#{rand(97000..99999)}}-#{rand(9700..9999)}" }
    cpf { "#{rand(100..999)}.#{rand(100..999)}.#{rand(100..999)}-#{rand(10..99)}" }
    user_type { 0 }
  end
end

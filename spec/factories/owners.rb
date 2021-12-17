FactoryBot.define do
  factory :owner do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, max_length: 20, mix_case: true) }
    age { rand(18..100) }
    store
  end
end

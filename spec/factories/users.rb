FactoryBot.define do
  factory :user do
    email { "test@email.com" }
    age { 32 }
    password_digest { "MyString" }
    type { "" }
    store
  end
end

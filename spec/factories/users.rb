FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "admin#{n}" }
    sequence(:email) { |n| "admin#{n}@example.com" }
    password { 'secret' }
  end
end

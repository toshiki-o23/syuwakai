FactoryBot.define do
  factory :user do
    sequence(:name)        { |n| "test_user_#{n}" }
    sequence(:email)       { |n| "person#{n}@example.com" }
    password               {"password"}
    password_confirmation  {"password"}
  end
end

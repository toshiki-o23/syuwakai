FactoryBot.define do
  factory :user do
    name                   {"市川浩之"}
    sequence(:email)       { |n| "person#{n}@example.com" }
    password               {"password"}
    password_confirmation  {"password"}
  end
end

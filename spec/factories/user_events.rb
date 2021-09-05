FactoryBot.define do
  factory :user_event do
    association :user
    association :event
  end
end
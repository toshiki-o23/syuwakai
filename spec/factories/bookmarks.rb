FactoryBot.define do
  factory :bookmark do
    association :user
    association :event
  end
end

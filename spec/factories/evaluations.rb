FactoryBot.define do
  factory :evaluation do
    comment { "content_test" }
    evaluation {"5"}
    association :user
    association :event
  end
end

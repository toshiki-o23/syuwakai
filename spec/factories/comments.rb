FactoryBot.define do
  factory :comment do
    content { "content_test" }
    association :user
    association :event
  end
end

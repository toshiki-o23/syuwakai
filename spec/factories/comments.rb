FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user { nil }
    event { nil }
  end
end

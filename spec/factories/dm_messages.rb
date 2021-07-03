FactoryBot.define do
  factory :dm_message do
    user { nil }
    room { nil }
    content { "MyText" }
  end
end

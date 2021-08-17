FactoryBot.define do
  factory :event do
    title   {"手話講座 「挨拶」"}
    content {"あいさつの手話をご紹介！"}
    association :user, factory: :user
    image   { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/syuwakai.png'), 'image/png') }
    venue   { "ZOOM" }
    level {"初級"}
    start_time {"2021-08-28 10:00:00"}
    finish_time {"2021-08-28 12:00:00"}
    number {"10"}
    fee {"100"}
  end
end

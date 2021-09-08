FactoryBot.define do
  factory :event do
    title   {"イッチーと東京ぶらり旅"}
    content {"開催者の気まぐれイベント。私と一緒に東京の隠れた名所を巡りませんか？江戸っ子イッチーがご案内します♪※交通費は各自の自己負担になります。"}
    association :user
    image   { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/syuwakai.png'), 'image/png') }
    venue   { "東京駅" }
    level {"上級"}
    start_time {"2021/9/27 9:00"}
    finish_time {"2021/9/27 20:00"}
    number {"3"}
    min_fee { 100 }
    max_fee { 100 }
  end
end

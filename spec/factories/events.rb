FactoryBot.define do
  factory :event do
    title   {"初心者必見！手話を学ぼう！"}
    content {"手話を全く知らないあなたでも大丈夫！簡単な挨拶から季節まで一時間ほど学びます！お待ちしております！！"}
    association :user, factory: :user
    image   { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/syuwakai.png'), 'image/png') }
  end
end
require 'faker'

  5.times do |n|
  name = Faker::Name.first_name
  email = Faker::Internet.email
  User.create!(
    name:         name, 
    email:        email,
    password:     "password",
  )
  title = Faker::JapaneseMedia::StudioGhibli.character
  content = Faker::Company.industry
  image = Faker::Company.logo
  venue = Faker::Company.name
  Event.create!(
    title: title,
    content: content,
    user_id: n+1,
    image: image,
    venue: venue
    )
  end

  5.times do |n|
    [
      ["test#{n}"]
    ].each do |name|
      User.create!(
        { name: name,
          email: Faker::Internet.email,
          password: Faker::Number.number(digits: 10)}
      )
    end
  end

  User.all.each do |user|
    user.events.create!(

    )
  end

#   [
#   ['test1@test.com', 'テスト太郎', image: File.open('./app/assets/images/test.jpg')],
#   ['test2@test.com', 'テスト徹子', image: File.open('./db/fixtures/test.jpg')]
# ].each do |mail, name, img|
#   User.create!(
#     { email: mail, name: name, image: img}
#   )

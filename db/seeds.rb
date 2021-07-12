require 'faker'

[
  ["手話サークル しゅわかい", "はじめて手話を学ぶあなたも、手話で話したいあなたも気軽に参加できるイベントを開催します！", "1"],
  ["山上恵美", "手話べり交流会を不定期にやります！", "2"],
  ["中川陽", "手話通訳士志望の学生です。", "3"]
].each do |name, introduce, n|
  User.create!(
    { 
      name: name,
      introduce: introduce,
      email: Faker::Internet.email,
      password: Faker::Number.number(digits: 10),
      image: File.open("./app/assets/images/people/#{n}.jpg")
    }
  )
end

  [
    ['手話講座 「挨拶」', 'あいさつの手話をご紹介！', 'ZOOM', '初級', '2021-08-28 10:00:00', '2021-08-28 12:00:00', '10', '1'],
    ['手話べりしたい人あつまれ〜！', 'テーマをいくつか用意しました！参加者同士で楽しく談笑していきませんか！', 'ZOOM', '中級', '2021-08-27 19:00:00', '2021-08-27 21:00:00', '5', '2'],
    ['手話通訳士試験に向けて', '聞き取り通訳試験問題の練習をしたいと思っています。一緒にやってくださる方大募集！お菓子や飲み物もあります〜！', '参加者のみ公開', '上級', '2020-08-29 10:00:00', '2020-08-29 17:00:00', '20', '3'],
    ['手話学習者向け交流会', '手話でうまく話せるようになりたいけど、人と手話べりする機会がない…と思っているそこの君！ディスカッション企画に参加してみない？', '東京都 新宿区', '中級', '2020-08-27 10:00:00', '2020-08-27 16:00:00', '30', '4']
  ].each do |title, content, venue, level, start, finish, number, image|
    Event.create!(
      {
        title: title,
        content: content,
        venue: venue,
        level: level,
        start_time: start,
        finish_time: finish,
        number: number,
        image: File.open("./app/assets/images/events/#{image}.jpg"),
        user_id: Faker::Number.between(from: 1, to: User.last.id)
      }
    )
  end

  [
    [1, 2],
    [2, 3]
  ].each do |user, follow|
  Relationship.create!(
    user_id: user,
    follow_id: follow
  )
end

Bookmark.create!(
  user_id: 1,
  event_id: 1
)

Room.create!(
  name: '手話を覚えるコツありますか？',
  content: 'こんにちは！手話を学び始めて2ヶ月目の初心者です。本を読みながら、手話を覚えようとしますが、なかなかスムーズに動けるようにはなりません。手話をすぐに覚えすぐに使えるようになるにはどうしたらいいですか？'
)

Message.create!(
  content: '私は手話通訳士です。一気に上達したなと感じたのは、実際に手話を使う人とおしゃべりすることです。なかなか知らない人とおしゃべりするのはハードル高いですが、勇気を出してしゅわかいのイベントに参加してみるのもいいと思いますよ！',
  user_id: 1,
  room_id: 1
)

Message.create!(
  content: ''
)

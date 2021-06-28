require 'faker'

[
  ["手話サークル しゅわかい", "はじめて手話を学ぶあなたも、手話で話したいあなたも気軽に参加できるイベントを開催します！"],
  ["手話太郎", "手話べり交流会を不定期にやります！"],
  ["通訳花子", "手話通訳士志望の学生です。"]
].each do |name, introduce|
  User.create!(
    { 
      name: name,
      introduce: introduce,
      email: Faker::Internet.email,
      password: Faker::Number.number(digits: 10)
    }
  )
end

  [
    ['手話講座 「挨拶」', 'あいさつの手話をご紹介！', 'ZOOM'],
    ['手話べりしたい人あつまれ〜！', 'テーマをいくつか用意しました！参加者同士で楽しく談笑していきませんか！', 'ZOOM'],
    ['手話通訳士試験に向けて', '聞き取り通訳試験問題の練習をしたいと思っています。一緒にやってくださる方大募集！お菓子や飲み物もあります〜！', '参加者のみ公開'],
    ['手話学習者向け交流会', '手話でうまく話せるようになりたいけど、人と手話べりする機会がない…と思っているそこの君！ディスカッション企画に参加してみない？', '東京都 新宿区 賢者屋']
  ].each do |title, content, venue|
    Event.create!(
      {
        title: title,
        content: content,
        venue: venue,
        user_id: Faker::Number.between(from: 1, to: User.last.id)
      }
    )
  end

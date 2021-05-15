class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :bookmarks
  has_many :bookmark_events, through: :bookmarks, source: :event

  # プロフィール画像許可
  mount_uploader :image, ImageUploader

  # ゲストログイン機能
  # https://qiita.com/take18k_tech/items/35f9b5883f5be4c6e104
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
end

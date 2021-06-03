class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_events, through: :bookmarks, source: :event

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy, inverse_of: :relationship
  has_many :followers, through: :reverse_of_relationships, source: :user

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: true }
  validates :password, presence: true

  # プロフィール画像許可
  mount_uploader :image, UserImageUploader
  # mount_uploader :user_image, UserImageUploader

  # ゲストログイン機能
  # https://qiita.com/take18k_tech/items/35f9b5883f5be4c6e104
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲスト'
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy if relationship
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end

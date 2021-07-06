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

  has_many :messages, dependent: :destroy

  has_many :dm_messages, dependent: :destroy
  has_many :dm_entries, dependent: :destroy

  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

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

  # パスワード無しで編集可能
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end
end

class Event < ApplicationRecord
  belongs_to :user, optional: true
  has_many :bookmarks, dependent: :destroy

  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :venue, presence: true

  # 引数を受け取るように設定
  def already_bookmarked?(user)
    bookmarks.exists?(user_id: user.id) if user.presence # ログインのみブックマークできる
  end

  # イベント画像投稿許可
  mount_uploader :image, ImageUploader
end

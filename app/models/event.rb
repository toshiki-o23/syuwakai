class Event < ApplicationRecord
  belongs_to :user, optional: true
  has_many :bookmarks

  validates :title, presence: true, length: { maximum: 30}
  validates :content, presence: true, length: { maximum: 1000 }

  def already_bookmarked?(user)#引数を受け取るように設定
    if user.presence #ログインのみブックマークできる
      bookmarks.where(user_id: user.id).exists?
    end
  end

  # イベント画像投稿許可
  mount_uploader :image, ImageUploader
end

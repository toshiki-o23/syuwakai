class Event < ApplicationRecord
  belongs_to :user, optional: true
  has_many :bookmarks

  def already_bookmarked?(user) #引数を受け取るように設定
    bookmarks.where(user_id: user.id).exists?
  end

  # イベント画像投稿許可
  mount_uploader :image, ImageUploader
end

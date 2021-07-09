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

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(event_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      event_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end

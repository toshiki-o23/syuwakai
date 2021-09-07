class Event < ApplicationRecord
  belongs_to :user, optional: true
  has_many :bookmarks, dependent: :destroy

  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  has_many :comments, dependent: :destroy

  has_many :evaluations, dependent: :destroy

  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :venue, presence: true
  validates :level, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true
  validates :number, presence: true, numericality: { greater_than_or_equal_to: 2 }
  validates :fee, presence: true, numericality: true

  validates :number, numericality: { greater_than_or_equal_to: :number }, on: :update

  validate :start_finish_check
  validate :start_check

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

  def start_finish_check
    errors.add(:finish_time, 'は開始時刻より遅い時間を選択してください') if self.start_time > self.finish_time
  end

  def start_check
    errors.add(:start_time, 'は現在の日時より遅い時間を選択してください') if self.start_time < Time.zone.now
  end

  # 検索メソッド、タイトルと内容をあいまい検索する
  def self.events_serach(search)
    Event.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  end

  def save_events(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    # Create
    new_tags.each do |new_name|
      event_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << event_tag
    end
  end

  # ブックマークされた数
  ransacker :bookmarks_count do
    query = '(SELECT COUNT(bookmarks.event_id) FROM bookmarks where bookmarks.event_id = events.id GROUP BY bookmarks.event_id)'
    Arel.sql(query)
  end
end

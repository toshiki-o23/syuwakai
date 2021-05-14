class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :bookmarks
  has_many :bookmark_events, through: :bookmarks, source: :event

    # プロフィール画像許可
  mount_uploader :image, ImageUploader
end

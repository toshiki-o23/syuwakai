class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :events, dependent: :destroy

    # プロフィール画像許可
  mount_uploader :image, ImageUploader
end

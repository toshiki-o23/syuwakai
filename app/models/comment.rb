class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :notifications, dependent: :destroy

  validates :content, presence: true, length: { maximum: 10_000 }
end

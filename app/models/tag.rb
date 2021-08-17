class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :events, through: :tagmaps
end

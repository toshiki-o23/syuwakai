class DmRoom < ApplicationRecord
  has_many :dm_messages, dependent: :destroy
  has_many :dm_entries, dependent: :destroy
end

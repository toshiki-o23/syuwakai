class Relationship < ApplicationRecord
  # https://qiita.com/engineer_ikuzou/items/fc16edd2578bee41e17f
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :user_id, presence: true
  validates :follow_id, presence: true
end

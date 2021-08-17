class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :event, optional: true

  validates :event_id, uniqueness: { scope: :user }
end

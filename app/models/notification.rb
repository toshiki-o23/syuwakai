class Notification < ApplicationRecord
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true

  belongs_to :comment, optional: true
  belongs_to :user_event, optional: true
end

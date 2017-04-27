class Score < ApplicationRecord
  belongs_to :class_subject
  belongs_to :students

  scope :newest, ->{order created_at: :desc}
end

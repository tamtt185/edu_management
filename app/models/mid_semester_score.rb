class MidSemesterScore < ApplicationRecord
  belongs_to :class_subject

  has_many :student_mid_semester_scores, dependent: :destroy

  scope :oldest, ->{order created_at: :asc}
end

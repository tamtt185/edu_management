class EndSemesterScore < ApplicationRecord
  belongs_to :class_subject

  has_many :student_end_semester_scores, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end

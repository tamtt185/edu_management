class StudentEndSemesterScore < ApplicationRecord
  belongs_to :student
  belongs_to :end_semester_score

  scope :newest, ->{order created_at: :desc}
end

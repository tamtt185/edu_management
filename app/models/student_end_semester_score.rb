class StudentEndSemesterScore < ApplicationRecord
  belongs_to :student
  belongs_to :end_semester_score

  scope :newest, ->{order created_at: :desc}
  scope :of_student, ->student_id do
    where student_id: student_id
  end
end

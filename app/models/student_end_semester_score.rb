class StudentEndSemesterScore < ApplicationRecord
  belongs_to :student
  belongs_to :end_semester_score
end

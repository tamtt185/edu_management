class StudentMidSemesterScore < ApplicationRecord
  belongs_to :student
  belongs_to :mid_semester_score
end

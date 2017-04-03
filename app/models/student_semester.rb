class StudentSemester < ApplicationRecord
  belongs_to :student
  belongs_to :semester
end

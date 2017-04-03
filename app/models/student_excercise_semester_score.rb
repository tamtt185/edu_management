class StudentExcerciseSemesterScore < ApplicationRecord
  belongs_to :student
  belongs_to :excercise_score
end

class StudentExerciseScore < ApplicationRecord
  belongs_to :student
  belongs_to :exercise_score
  
  scope :newest, ->{order created_at: :desc}
end

class ExerciseScore < ApplicationRecord
  belongs_to :exercise
  
  has_many :student_exercise_scores, dependent: :destroy

  scope :oldest, ->{order created_at: :asc}
end

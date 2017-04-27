class ExerciseScore < ApplicationRecord
  belongs_to :class_subject
  
  has_many :student_exercise_scores, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end

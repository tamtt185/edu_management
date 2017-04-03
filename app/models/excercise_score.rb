class ExcerciseScore < ApplicationRecord
  belongs_to :class_subject
  
  has_many :student_excercise_scores, dependent: :destroy
end

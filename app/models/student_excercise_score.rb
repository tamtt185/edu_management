class StudentExcerciseScore < ApplicationRecord
  belongs_to :student
  belongs_to :excercise_score
  
  scope :newest, ->{order created_at: :desc}
end

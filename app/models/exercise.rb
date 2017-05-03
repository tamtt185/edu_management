class Exercise < ApplicationRecord
  belongs_to :class_subject

  has_many :exercise_scores, dependent: :destroy
  accepts_nested_attributes_for :exercise_scores, allow_destroy: true
end

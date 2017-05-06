class Score < ApplicationRecord
  belongs_to :class_subject

  has_many :sub_scores, dependent: :destroy
  accepts_nested_attributes_for :sub_scores, allow_destroy: true

  enum score_type: [:exercise, :mid_semester, :end_semester]

  scope :get_exercise_score, ->{where(score_type: :exercise).first}
  scope :get_mid_semester_score, ->{where(score_type: :mid_semester).first}
  scope :get_end_semester_score, ->{where(score_type: :end_semester).first}
end

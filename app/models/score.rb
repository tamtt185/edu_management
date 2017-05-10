class Score < ApplicationRecord
  belongs_to :class_subject
  has_many :sub_scores, dependent: :destroy
  accepts_nested_attributes_for :sub_scores, allow_destroy: true

  enum score_type: [:exercise, :mid_semester, :end_semester, :diligence, :protect, :project]

  scope :get_exercise_score, ->{where(score_type: :exercise)}
  scope :get_mid_semester_score, ->{where(score_type: :mid_semester)}
  scope :get_end_semester_score, ->{where(score_type: :end_semester)}
  scope :get_diligence_score, ->{where(score_type: :diligence)}
  scope :get_protect_score, ->{where(score_type: :protect)}
  scope :get_project_score, ->{where(score_type: :protect)}
end

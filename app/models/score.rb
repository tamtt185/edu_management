class Score < ApplicationRecord
  belongs_to :class_subject

  has_many :sub_scores, dependent: :destroy
  accepts_nested_attributes_for :sub_scores, allow_destroy: true

  enum score_type: [:exercise, :mid_semester, :end_semester]
end

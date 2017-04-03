class ClassSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :lecturer
  belongs_to :semester

  has_many :end_semester_scores, dependent: :destroy
  has_many :mid_semester_scores, dependent: :destroy
  has_many :excercise_scores, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :student_class_subjects, dependent: :destroy
end

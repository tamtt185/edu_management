class Semester < ApplicationRecord
  has_many :student_semesters, dependent: :destroy
  has_many :class_subjects, dependent: :destroy
end

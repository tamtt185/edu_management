class Faculty < ApplicationRecord
  has_many :student_classes, dependent: :destroy
  has_many :lecturers, dependent: :destroy
end

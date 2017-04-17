class Course < ApplicationRecord
  has_many :curriculums, dependent: :destroy
  has_many :student_classes, dependent: :destroy
end

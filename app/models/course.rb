class Course < ApplicationRecord
  belongs_to :curriculum

  has_many :student_classes, dependent: :destroy
end

class Course < ApplicationRecord
  has_many :curriculums, dependent: :destroy
  has_many :student_classes, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end

class Course < ApplicationRecord
  has_many :student_classes, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end

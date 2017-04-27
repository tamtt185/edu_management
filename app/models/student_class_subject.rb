class StudentClassSubject < ApplicationRecord
  belongs_to :student
  belongs_to :class_subject

  scope :newest, ->{order created_at: :desc}
end

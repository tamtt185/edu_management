class StudentClassSubject < ApplicationRecord
  belongs_to :student
  belongs_to :class_subject
end

class StudentClassSubject < ApplicationRecord
  belongs_to :student
  belongs_to :class_subject

  scope :score_of_student, ->student_id do 
    where(student_id: student_id).first
  end

  scope :of_class_subject, ->class_subject_id do
  	where(class_subject_id: class_subject_id).first
  end
end

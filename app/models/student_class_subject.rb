class StudentClassSubject < ApplicationRecord
  belongs_to :student
  belongs_to :class_subject

  validates :student_class_subject_id, presence: true, length: {maximum: 30},
    uniqueness: true
  
  validates :avg_exercise_score, numericality: true, allow_nil: true
  validates :avg_mid_semester_score, numericality: true, allow_nil: true
  validates :avg_end_semester_score, numericality: true, allow_nil: true
  validates :avg_diligence_score, numericality: true, allow_nil: true
  validates :avg_protect_score, numericality: true, allow_nil: true
  validates :avg_project_score, numericality: true, allow_nil: true
  validates :avg_score, numericality: true, allow_nil: true
  validates :gpa_score, numericality: true, allow_nil: true

  scope :score_of_student, ->student_id do 
    where(student_id: student_id).first
  end

  scope :of_class_subject, ->class_subject_id do
  	where(class_subject_id: class_subject_id).first
  end

  scope :confirmed, -> {where is_confirm: 1}
end

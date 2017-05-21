class ClassSubject < ApplicationRecord
  belongs_to :semester
  belongs_to :lecturer_subject

  has_many :scores, dependent: :destroy
  has_many :student_class_subjects, dependent: :destroy
  has_many :students, through: :student_class_subjects

  validates :class_subject_id, presence: true, length: {maximum: 30},
    uniqueness: true
  validates :lecturer_subject_id, presence: true
  validates :semester_id, presence: true

  scope :newest, ->{order created_at: :desc}

  scope :get_class_of_lecturer_subject, -> lecturer_subject_id do
    where lecturer_subject_id: lecturer_subject_id
  end  
end

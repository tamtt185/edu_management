class Semester < ApplicationRecord
  has_many :student_semesters, dependent: :destroy
  has_many :class_subjects, dependent: :destroy

  scope :newest, ->{order created_at: :desc}

  validates :semester_id, presence: true, length: {maximum: 20},
    uniqueness: true
  validates :name, presence: true, length: {maximum: 100}
  validates :period, presence: true, length: {maximum: 12}

  scope :non_confirmed, -> {where status: 0}
end

class LecturerSubject < ApplicationRecord
  belongs_to :lecturer
  belongs_to :subject

  has_many :class_subjects, dependent: :destroy

  validates :subject_id, presence: true, uniqueness: true

  scope :newest, ->{order created_at: :desc}
  scope :get_lecturer_subject, -> (lecturer_id, subject_id) do
  	where("lecturer_id = ?  AND subject_id = ?", lecturer_id, subject_id)
  end
end

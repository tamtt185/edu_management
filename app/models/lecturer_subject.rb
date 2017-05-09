class LecturerSubject < ApplicationRecord
  belongs_to :lecturer
  belongs_to :subject

  has_many :class_subjects, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end

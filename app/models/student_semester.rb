class StudentSemester < ApplicationRecord
  belongs_to :student
  belongs_to :semester

  scope :newest, ->{order created_at: :desc}
end

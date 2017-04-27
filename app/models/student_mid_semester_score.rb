class StudentMidSemesterScore < ApplicationRecord
  belongs_to :student
  belongs_to :mid_semester_score

  scope :newest, ->{order created_at: :desc}
end

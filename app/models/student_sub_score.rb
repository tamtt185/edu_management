class StudentSubScore < ApplicationRecord
  belongs_to :student
  belongs_to :sub_score
  
  scope :newest, ->{order created_at: :desc}
  scope :score_of_student, ->student_id do 
    where(student_id: student_id).first
  end

  scope :confirmed, -> {where is_confirm: 1}

  scope :find_student_sub_score, ->(student_id, sub_score_id) do
  	where("student_id = ? AND sub_score_id = ?", student_id, sub_score_id)
  end
end

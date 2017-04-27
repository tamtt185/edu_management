class ClassLeader < ApplicationRecord
  belongs_to :lecturer
  belongs_to :student_class

  scope :newest, ->{order created_at: :desc}
end

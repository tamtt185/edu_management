class SubScore < ApplicationRecord
  belongs_to :score
  
  has_many :student_sub_scores, dependent: :destroy
  
  validates :name, presence: true, length: {maximum: 10}
  
  scope :oldest, ->{order created_at: :asc}
end

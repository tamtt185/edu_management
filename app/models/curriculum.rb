class Curriculum < ApplicationRecord
  belongs_to :course
  belongs_to :faculty
  
  has_many :curriculum_subjects, dependent: :destroy
  has_many :subjects, through: :curriculum_subjects

  scope :newest, ->{order created_at: :desc}
end

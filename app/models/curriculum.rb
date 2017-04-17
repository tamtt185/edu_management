class Curriculum < ApplicationRecord
  belongs_to :course
  
  has_many :curriculum_subjects, dependent: :destroy
end

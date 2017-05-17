class Curriculum < ApplicationRecord
  belongs_to :faculty
  
  has_many :students, dependent: :destroy
  has_many :curriculum_subjects, dependent: :destroy
  has_many :subjects, through: :curriculum_subjects

  scope :newest, ->{order created_at: :desc}

  validates :curriculum_id, presence: true, length: {maximum: 20},
    uniqueness: true
  validates :name, presence: true, length: {maximum: 255},
    uniqueness: true
end

class Curriculum < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :curriculum_subjects, dependent: :destroy
end

class Subject < ApplicationRecord
  has_many :class_subjects, dependent: :destroy
  has_many :curriculum_subjects, dependent: :destroy
end

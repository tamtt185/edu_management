class StudentClass < ApplicationRecord
  belongs_to :faculty
  belongs_to :course

  has_many :students, dependent: :destroy
  has_many :class_leaders, dependent: :destroy
end

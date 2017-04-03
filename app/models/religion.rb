class Religion < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :lecturers, dependent: :destroy
end

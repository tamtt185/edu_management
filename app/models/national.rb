class National < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :lecturers, dependent: :destroy
  has_many :ethnics, dependent: :destroy
end

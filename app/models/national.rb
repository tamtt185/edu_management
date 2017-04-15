class National < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :lecturers, dependent: :destroy
  has_many :ethnics, dependent: :destroy
  
  validates :name, presence: true, length: {maximum: 50}
end

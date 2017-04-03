class Ethnic < ApplicationRecord
  belongs_to :national
  
  has_many :students, dependent: :destroy
  has_many :lecturers, dependent: :destroy
end

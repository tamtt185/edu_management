class Religion < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :lecturers, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end

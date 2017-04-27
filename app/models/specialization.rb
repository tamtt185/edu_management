class Specialization < ApplicationRecord
  has_many :students, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
end

class Regency < ApplicationRecord
  has_many :students, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
  validates :plus_point, presence: true

  scope :newest, ->{order created_at: :desc}
end

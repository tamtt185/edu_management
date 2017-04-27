class Ethnic < ApplicationRecord
  belongs_to :national

  validates :name, presence: true, length: {maximum: 50}

  scope :newest, ->{order created_at: :desc}
end

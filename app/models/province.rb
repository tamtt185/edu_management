class Province < ApplicationRecord
  belongs_to :national

  scope :newest, ->{order created_at: :desc}
end

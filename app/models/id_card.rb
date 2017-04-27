class IdCard < ApplicationRecord
  belongs_to :student
  belongs_to :province

  scope :newest, ->{order created_at: :desc}
end

class IdCard < ApplicationRecord
  belongs_to :student
  belongs_to :province
end

class Regency < ApplicationRecord
 has_many :students, dependent: :destroy
end

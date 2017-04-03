class Lecturer < ApplicationRecord
  belongs_to :national
  belongs_to :ethnic
  belongs_to :religion
  belongs_to :account
  belongs_to :faculty
end

class Student < ApplicationRecord
  belongs_to :national
  belongs_to :ethnic
  belongs_to :religion
  belongs_to :account
  belongs_to :specialization
  belongs_to :student_class
  belongs_to :curriculum
end

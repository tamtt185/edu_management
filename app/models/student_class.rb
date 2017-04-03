class StudentClass < ApplicationRecord
  belongs_to :faculty
  belongs_to :course
end

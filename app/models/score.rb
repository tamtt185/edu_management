class Score < ApplicationRecord
  belongs_to :class_subject
  belongs_to :students
end

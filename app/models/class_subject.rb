class ClassSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :lecturer
  belongs_to :semester
end

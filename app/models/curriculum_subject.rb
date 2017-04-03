class CurriculumSubject < ApplicationRecord
  belongs_to :curriculum
  belongs_to :subject
end

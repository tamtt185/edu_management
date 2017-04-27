class LecturerSubject < ApplicationRecord
  belongs_to :lecturer
  belongs_to :subject
end

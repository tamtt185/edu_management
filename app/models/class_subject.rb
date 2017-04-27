class ClassSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :lecturer
  belongs_to :semester

  has_many :end_semester_scores, dependent: :destroy
  has_many :mid_semester_scores, dependent: :destroy
  has_many :excercise_scores, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :student_class_subjects, dependent: :destroy

  validates :class_subject_id, presence: true, length: {maximum: 10},
    uniqueness: true
  validates :subject_id, presence: true
  validates :semester_id, presence: true

  scope :newest, ->{order created_at: :desc}
  
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = ["class_subject_id", "subject_id", "lecturer_id","semester_id"]
    (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        subject = find_by_id(row["id"]) || new
        subject.attributes = row.to_hash.slice(*row.to_hash.keys)
        subject.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file.original_filename}"
    end
  end
end

class Subject < ApplicationRecord
  has_many :curriculum_subjects, dependent: :destroy
  has_many :curriculums, through: :curriculum_subjects
  has_many :lecturer_subjects, dependent: :destroy
  has_many :lecturers, through: :lecturer_subjects
  has_many :class_subjects, through: :lecturer_subjects

  validates :subject_id, presence: true, length: {maximum: 20},
    uniqueness: true
  validates :name, presence: true, length: {maximum: 100},
    uniqueness: true
  validates :num_of_credit, presence: true, numericality: true
  
  enum subject_type: [:theory, :practice, :project, :intership]

  scope :newest, ->{order created_at: :desc}

  attr_accessor :import_faild

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = ["subject_id", "name", "num_of_credit"]
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

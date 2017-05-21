class Curriculum < ApplicationRecord
  belongs_to :faculty
  
  has_many :students, dependent: :destroy
  has_many :curriculum_subjects, dependent: :destroy
  has_many :subjects, through: :curriculum_subjects

  scope :newest, ->{order created_at: :desc}

  validates :curriculum_id, presence: true, length: {maximum: 20},
    uniqueness: true
  validates :name, presence: true, length: {maximum: 255},
    uniqueness: true

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = ["curriculum_id", "name", "faculty_id"]
    (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        curriculum = find_by_curriculum_id(row["curriculum_id"]) || new
        curriculum.attributes = row.to_hash.slice(*row.to_hash.keys)
        unless curriculum.save!
           flash[:danger] = "Import dữ liệu thất bại"
        end 
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

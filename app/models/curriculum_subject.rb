class CurriculumSubject < ApplicationRecord
  belongs_to :curriculum
  belongs_to :subject

  scope :semester_asc, ->{order semester: :asc}
  validates :curriculum_subject_id, presence: true, length: {maximum: 20},
    uniqueness: true
  validates :semester, presence: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 10}
 
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = ["subject_id", "curriculum_id", "semester"]
    (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        cur_subject_id = "HP_CTDT"+ "." + row["subject_id"].to_s + "." + row["curriculum_id"].to_s
        cur_subject = find_by_curriculum_subject_id(cur_subject_id) || new(curriculum_subject_id: cur_subject_id)
        cur_subject.attributes = row.to_hash.slice(*row.to_hash.keys)
        unless cur_subject.save!
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

  private
  def image_size
    if avatar.size > 5.megabytes
      errors.add :avatar, "kích thước vượt quá 5MB"
    end
  end
end

class CurriculumSubject < ApplicationRecord
  belongs_to :curriculum
  belongs_to :subject

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = ["subject_id", "curriculum_id"]
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

  private
  def image_size
    if avatar.size > 5.megabytes
      errors.add :avatar, "kích thước vượt quá 5MB"
    end
  end
end

class Student < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:student_id]

  belongs_to :national
  belongs_to :ethnic
  belongs_to :religion
  belongs_to :regency
  belongs_to :specialization
  belongs_to :student_class
  belongs_to :province
  belongs_to :course
  belongs_to :curriculum

  has_one :id_card, dependent: :destroy

  has_many :student_semesters, dependent: :destroy
  has_many :student_mid_semester_scores, dependent: :destroy
  has_many :student_excercise_scores, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :student_class_subjects, dependent: :destroy
  has_many :clss_subjects, through: :student_class_subjects

  enum gender: [:male, :female]

  validates :student_id, presence: true, length: {maximum: 10},
    uniqueness: true
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/
  validates :email, presence: true, length: {maximum: 30},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :phone, length: {maximum: 15}, 
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, length: {maximum: 255}
  validates :password, length: {minimum: 6}, allow_nil: true

  mount_uploader :avatar, PictureUploader
  validate :image_size

  scope :newest, ->{order created_at: :desc}

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = ["student_id", "name", "email", "birthday", "gender", "phone", "password"]
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

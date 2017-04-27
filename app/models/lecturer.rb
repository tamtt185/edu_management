class Lecturer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:lecturer_id]

  belongs_to :national
  belongs_to :ethnic
  belongs_to :religion
  belongs_to :faculty

  has_many :class_leaders, dependent: :destroy
  has_many :class_subjects, dependent: :destroy
  has_many :lecturer_subjects, dependent: :destroy
  has_many :subjects, through: :lecturer_subjects

  enum gender: [:male, :female]

  validates :lecturer_id, presence: true, length: {maximum: 10}
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
    header = ["lecturer_id", "name", "email", "birthday", "gender", "phone", "password"]
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

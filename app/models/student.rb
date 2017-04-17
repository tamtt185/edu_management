class Student < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :national
  belongs_to :ethnic
  belongs_to :religion
  belongs_to :regency
  belongs_to :specialization
  belongs_to :student_class
  belongs_to :province
  belongs_to :course

  has_one :id_card, dependent: :destroy

  has_many :student_semesters, dependent: :destroy
  has_many :student_mid_semester_scores, dependent: :destroy
  has_many :student_excercise_scores, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :student_class_subjects, dependent: :destroy

  enum gender: [:male, :female]

  validates :student_id, presence: true, length: {maximum: 10},
    uniqueness: true
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/
  validates :email, presence: true, length: {maximum: 30},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :phone, presence: true, length: {maximum: 15}, 
    format: {with: VALID_PHONE_NUMBER_REGEX}
  validates :address, presence: true, length: {maximum: 255}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  mount_uploader :avatar, PictureUploader
  validate :image_size

  private
  def image_size
    if avatar.size > 5.megabytes
      errors.add :avatar, "kích thước vượt quá 5MB"
    end
  end
end

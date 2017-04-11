class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :national
  belongs_to :ethnic
  belongs_to :religion
  belongs_to :specialization
  belongs_to :student_class
  belongs_to :curriculum
  belongs_to :province

  has_one :id_card, dependent: :destroy
  has_one :account, dependent: :destroy

  has_many :student_semesters, dependent: :destroy
  has_many :student_mid_semester_scores, dependent: :destroy
  has_many :student_excercise_scores, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :student_class_subjects, dependent: :destroy

  enum gender: [:male, :female]
end

class Lecturer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :national
  belongs_to :ethnic
  belongs_to :religion
  belongs_to :faculty

  has_one :account, dependent: :destroy
  has_many :class_leaders, dependent: :destroy
  has_many :class_subjects, dependent: :destroy
end

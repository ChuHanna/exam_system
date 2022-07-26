class User < ApplicationRecord
  USER_PARAMS = %i(name email status role password password_confirmation).freeze

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum role: {trainee: 0, trainer: 1, admin: 2}, _suffix: true
  enum status: {inactive: 0, active: 1, pending: 2}, _suffix: true


  has_many :exams
  has_many :topics
  has_many :subjects
  has_many :records

  validates :email, presence: true
  validates :name, presence: true
end

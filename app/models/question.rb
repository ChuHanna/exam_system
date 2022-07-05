class Question < ApplicationRecord
  belongs_to :topic
  QUESTION_PARAMS = [:description, :level, :question_type,
    answers_attributes: [:id, :description, :check, :_destroy]].freeze

  scope :get_list, ->{select(:id, :description)}

  enum level: {easy:0, medium: 1, difficult: 2}, _prefix: :level
  enum question_type: {single_choice: 0, multiple_choice: 1, essay: 2}, _prefix: :question_type

  validates :description, presence: true

  has_many :answers, dependent: :destroy
  has_many :questions_exams
  has_many :exams, through: :questions_exams

  accepts_nested_attributes_for :answers, allow_destroy: true
end

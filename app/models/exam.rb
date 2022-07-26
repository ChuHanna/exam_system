class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  EXAM_PARAMS = [:topic_id, question_ids: [], questions_exams_attributes:
    [:id, :exam_id, :question_id]].freeze

  scope :order_by_created_at, ->{order created_at: :desc}

  # delegate :suppervisor, :trainee, :admin, :name, to: :users, prefix: :user
  delegate :name, to: :topic, prefix: true

  has_many :questions_exams, dependent: :destroy
  has_many :questions, through: :questions_exams
  has_many :users, dependent: :destroy
  has_one :result, dependent: :destroy
  has_many :records

  accepts_nested_attributes_for :questions_exams, allow_destroy: true
  after_create :create_exam_question

  private
  def create_exam_question
    topic.questions.each do |question|
      questions_exams.create! question_id: question.id
    end
  end
end

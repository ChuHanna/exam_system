class QuestionsExam < ApplicationRecord
  belongs_to :exam
  belongs_to :question

  QUESTIONS_EXAM_PARAMS = [:exam_id, question_id: [], question_ids: []].freeze
  delegate :description, to: :question, prefix: true
end

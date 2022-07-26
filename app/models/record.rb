class Record < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  belongs_to :answer

  scope :by_exam_id, ->(exam_id){where exam_id: exam_id}
end

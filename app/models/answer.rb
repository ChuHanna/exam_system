class Answer < ApplicationRecord
  belongs_to :question
  # validates :ans, presence: true
  # validates :content, presence: true
end

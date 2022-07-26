class Answer < ApplicationRecord
  belongs_to :question
  has_many :records
  # validates :ans, presence: true
  # validates :content, presence: true
end

class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  TOPIC_PARAMS = %i(description duration).freeze
  delegate :name, to: :subject, prefix: true
  has_many :exams

  validates :description, presence: true
  validates :duration, presence: true # đơn vị phút
end

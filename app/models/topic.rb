class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  TOPIC_PARAMS = %i(subject_id name description duration).freeze
  scope :order_by_created_at, ->{order created_at: :desc}

  delegate :name, to: :subject, prefix: true
  has_many :exams
  has_many :questions

  validates :description, presence: true
  validates :duration, presence: true # đơn vị phút
end

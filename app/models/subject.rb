class Subject < ApplicationRecord
  belongs_to :user
  has_many :topics

  SUBJECT_PARAMS = %i(description).freeze

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :order_by_name, ->{order name: :desc}

  delegate :name, to: :user, prefix: true

  validates :name, presence: true, length: {maximum: Settings.max_name_subject}
  validates :description, presence: true
end

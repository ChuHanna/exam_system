class Subject < ApplicationRecord
  belongs_to :user

  SUBJECT_PARAMS = %i(description).freeze

  delegate :name, to: :user, prefix: true
  has_many :topics

  validates :name, presence: true, length: {maximum: Settings.max_name_subject}
  validates :description, presence: true
end

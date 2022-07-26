class Result < ApplicationRecord
  belongs_to :user
  belongs_to :exam

  # validates :score, greater_than: 0
  before_create :update_time

  enum status: {pending: 0, passed: 1, failed: 2}

  private

  def update_time
    Exam.update time_end: Time.zone.now
  end
end

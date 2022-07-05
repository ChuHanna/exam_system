class Result < ApplicationRecord
  belongs_to :user
  belongs_to :exam

  validates :score, minimum: 0
end

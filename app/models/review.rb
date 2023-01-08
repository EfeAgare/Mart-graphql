class Review < ApplicationRecord
  belongs_to :product

  validates :review, presence: true
  validates :rating, presence: true
  validates :created_on, presence: true
end

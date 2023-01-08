class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :shipping
  belongs_to :tax

  has_many :order_details

  validates :total_amount, presence: true
  validates :created_on, presence: true
end

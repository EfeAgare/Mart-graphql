class Product < ApplicationRecord
  has_many :product_categories
  has_many :order_details

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :discounted_price, presence: true
end

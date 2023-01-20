class Product < ApplicationRecord
  has_many :product_categories
  has_many :order_details
  has_many :reviews

  paginates_per 25

  include PgSearch::Model
  
  pg_search_scope :search,
                  against: [:name, :description],
                  using: {
                    tsearch: { prefix: true }
                  }

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :discounted_price, presence: true
end

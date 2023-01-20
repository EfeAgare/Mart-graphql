class Review < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  validates :review, presence: true
  validates :rating, presence: true

  # scope :product_reviews, -> (id) { 
  #   find_by_sql([" SELECT c.name, r.review, r.rating, r.created_on
  #        FROM  reviews r INNER JOIN customers c
  #         ON c.id = r.customer_id
  #        WHERE  r.product_id = ?
  #       ORDER BY  r.created_on DESC", id])

  # }


end

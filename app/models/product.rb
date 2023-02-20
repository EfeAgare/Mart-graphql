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

  scope :fetch, -> (department_id, per_page, page) {find_by_sql(["SELECT DISTINCT p.id, p.name, p.price, p.description, p.image, p.image_2, p.discounted_price, p.thumbnail, p.display
        FROM            products p
        INNER JOIN      product_categories pc
                          ON p.id = pc.product_id
        INNER JOIN      categories c
                          ON pc.category_id = c.id
        WHERE          c.department_id = ? 
        LIMIT ? OFFSET ?", department_id, per_page, page])}
end


# frozen_string_literal: true

module Queries
  class Product::FetchProductsInDepartment < Queries::BaseQuery

   argument :page, Integer, required: false
   argument :per_page, Integer, required: false
   argument :department_id, ID, required: true

    type Types::Models::Product::PaginationType, null: false
    
    def resolve(**params)

      per_page = params[:per_page].present? ?  params[:per_page] : 25

      page = params[:page].present? ? (params[:page] - 1) * per_page : 0

      products = ::Product.find_by_sql(["SELECT DISTINCT p.id, p.name, p.price, p.description, p.image, p.image_2, p.discounted_price, p.thumbnail, p.display
        FROM            products p
        INNER JOIN      product_categories pc
                          ON p.id = pc.product_id
        INNER JOIN      categories c
                          ON pc.category_id = c.id
        WHERE          c.department_id = ? 
        LIMIT ? OFFSET ?", params[:department_id], per_page, page])

      {
        products: products,
        total_pages: products.length / per_page,
        count: products.length
      }

    end
  end
end

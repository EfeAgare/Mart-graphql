
# frozen_string_literal: true

module Queries
  class Product::ProductSearch < Queries::BaseQuery

   argument :page, Integer, required: false
   argument :per_page, Integer, required: false
   argument :query, String, required: true

    type Types::Models::Product::PaginationType, null: false
    
    def resolve(**params)

      page = params[:page].present? ? params[:page] : 1

      per_page = params[:per_page].present? ?  params[:per_page] : 25

      products = ::Product.search("#{params[:query]}").page(page).per(per_page)

      {
        products: products,
        total_pages: products.length / per_page,
        count: products.length
      }
    end
  end
end


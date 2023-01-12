# frozen_string_literal: true

module Queries
  class Category::FetchProductCategory < Queries::BaseQuery

    argument :product_id, ID, required: true

    type Types::Models::CategoryType, null: false
    
    def resolve(**params)
      product_category = ::ProductCategory.find_by_product_id(params[:product_id])

      product_category.category
    rescue ActiveRecord::RecordNotFound => e
      not_found("#{e}")
    end
  end
end

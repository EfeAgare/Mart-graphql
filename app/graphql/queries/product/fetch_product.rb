
# frozen_string_literal: true

module Queries
  class Product::FetchProduct < Queries::BaseQuery

   argument :id, ID, required: true

    type Types::Models::Product::ProductType, null: false
    
    def resolve(**params)

      product = ::Product.find(params[:id])

      product
    rescue ActiveRecord::RecordNotFound => e
      not_found("#{e}")
    end
  end
end

module Queries
  class Product::FetchProductReviews < Queries::BaseQuery

   argument :product_id, ID, required: true

    type [Types::Models::Product::ReviewType], null: true
    
    def resolve(**params)

      product = ::Review.includes(:customer).where(product_id: params[:product_id])

      product
    rescue ActiveRecord::RecordNotFound => e
      not_found("#{e}")
    end
  end
end
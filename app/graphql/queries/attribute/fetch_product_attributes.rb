# frozen_string_literal: true

module Queries
  class Attribute::FetchProductAttributes < Queries::BaseQuery

    argument :product_id, ID, required: true

    type Types::Models::ProductAttributeType, null: false
    
    def resolve(**params)
      product_Attribute = ::ProductAttribute.includes(:attribute_value).find_by_product_id(params[:product_id])

      product_Attribute
    rescue ActiveRecord::RecordNotFound => e
      not_found("#{e}")
    end
  end
end

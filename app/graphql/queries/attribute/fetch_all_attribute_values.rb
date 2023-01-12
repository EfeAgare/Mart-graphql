# frozen_string_literal: true

module Queries
  class Attribute::FetchAllAttributeValues < Queries::BaseQuery

    argument :attribute_id, ID, required: true

    type [Types::Models::AttributeValueType], null: false
    
    def resolve(**params)
      attribute_values = ::AttributeValue.where(attribute_id: params[:attribute_id])
      
      attribute_values
    end
  end
end

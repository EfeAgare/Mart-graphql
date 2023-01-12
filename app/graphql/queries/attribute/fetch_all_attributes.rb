# frozen_string_literal: true

module Queries
  class Attribute::FetchAllAttributes < Queries::BaseQuery

    type [Types::Models::AttributeType], null: false
    
    def resolve(**params)
      attributes = ::Attribute.all
      
      attributes
    end
  end
end

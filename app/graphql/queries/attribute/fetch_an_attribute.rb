# frozen_string_literal: true

module Queries
  class Attribute::FetchAnAttribute < Queries::BaseQuery

    argument :id, ID, required: true

    type Types::Models::AttributeType, null: false
    
    def resolve(**params)
      attribute = ::Attribute.find(params[:id])

      attribute
    rescue ActiveRecord::RecordNotFound => e
      not_found("#{e}")
    end
  end
end

# frozen_string_literal: true

module Queries
  class Tax::FetchTax < Queries::BaseQuery

    argument :id, ID, required: true

    type Types::Models::TaxType, null: false
    
    def resolve(**params)
      tax = ::Tax.find(params[:id])

      tax
    rescue ActiveRecord::RecordNotFound => e
      not_found("#{e}")
    end
  end
end

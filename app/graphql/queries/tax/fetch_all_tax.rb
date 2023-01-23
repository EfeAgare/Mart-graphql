# frozen_string_literal: true

module Queries
  class Tax::FetchAllTax < Queries::BaseQuery

    type [Types::Models::TaxType], null: false
    
    def resolve(**params)
      taxes = ::Tax.all

      taxes
    end
  end
end

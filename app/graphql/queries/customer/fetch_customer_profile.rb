# frozen_string_literal: true

module Queries
  class Customer::FetchCustomerProfile < Queries::BaseQuery

    type Types::Models::CustomerType, null: false
    
    def resolve(**params)
      current_user
    end

    def current_user
      context[:current_user]
    end
  end
end

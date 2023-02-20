# frozen_string_literal: true

module Queries
  class Order::FetchCustomerOrders < Queries::BaseQuery
    argument :customer_id, Types::ToInt, required: true

    type [Types::Models::Order::OrderType], null: true
    
    def resolve(**params)
      order = ::Order.joins(:customer).order("created_at DESC").where(customer_id: params[:customer_id])

      order
    end
  end
end
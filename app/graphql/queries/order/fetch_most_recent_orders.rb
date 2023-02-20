# frozen_string_literal: true

module Queries
  class Order::FetchMostRecentOrders < Queries::BaseQuery
    argument :per, Types::ToInt, required: true
    argument :customer_id, Types::ToInt, required: true

    type [Types::Models::Order::OrderType], null: false
    
    def resolve(**params)
      order = ::Order.includes(:customer).order("created_at DESC").where(customer_id: params[:customer_id]).limit(params[:per])

      order
    end
  end
end
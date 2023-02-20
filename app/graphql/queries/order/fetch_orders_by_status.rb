# frozen_string_literal: true

module Queries
  class Order::FetchOrdersByStatus < Queries::BaseQuery
    argument :status, Types::ToInt, required: true

    type [Types::Models::Order::OrderType], null: true
    
    def resolve(**params)
      order = ::Order.includes(:tax, :shipping).where(status: params[:status])

      order
    end
  end
end

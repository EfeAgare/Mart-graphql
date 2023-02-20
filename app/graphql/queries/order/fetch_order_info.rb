# frozen_string_literal: true

module Queries
  class Order::FetchOrderInfo < Queries::BaseQuery
    argument :id, ID, required: true

    type Types::Models::Order::OrderType, null: false
    
    def resolve(**params)
      order = ::Order.includes(:tax, :shipping).find(params[:id])

      order
    end
  end
end

# frozen_string_literal: true

module Queries
  module Order
    class FetchOrderDetails < Queries::BaseQuery
      argument :order_id, ID, required: true

      type [Types::Models::Order::OrderDetailType], null: false
      
      def resolve(**params)
        order = ::OrderDetail.fetch(params[:order_id])

        order
      end
    end
  end
end

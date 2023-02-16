# frozen_string_literal: true

module Types
  module Models
    class Order::PaginationType < ::Types::BaseObject
      field :orders, [Types::Models::Order::OrderType], null: true
      field :total_pages, Integer, null: true
      field :count, Integer, null: true
    end
  end
end

# frozen_string_literal: true

module Types
  module Models
    class Product::PaginationType < ::Types::BaseObject
      field :products, [Types::Models::Product::ProductType], null: true
      field :total_pages, Integer, null: true
      field :count, Integer, null: true
    end
  end
end

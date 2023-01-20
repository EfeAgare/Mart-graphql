# frozen_string_literal: true

module Types
  module Models
    class Product::ReviewType < ::Types::BaseObject
     field :review, String, null: false
     field :rating, Integer, null: false
     field :product_id, ID, null: false
     field :id, ID, null: false
     field :customer, Types::Models::CustomerType, null: true

     def customer
      object.customer
     end
    end
  end
end

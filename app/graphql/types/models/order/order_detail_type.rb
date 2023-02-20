# frozen_string_literal: true

module Types
  module Models
    class Order::OrderDetailType < ::Types::BaseObject
     field :id, ID, null: false
     field :order_id, Types::ToInt, null: true
     field :unit_cost, Types::ToDecimal,  null: false
     field :attributes, String, null: true
     field :product_name, String, null: true
     field :product_id, Types::ToInt, null: false
     field :quantity, Types::ToInt, null: false
    end
  end
end

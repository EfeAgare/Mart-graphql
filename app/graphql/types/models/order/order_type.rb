# frozen_string_literal: true

module Types
  module Models
    class Order::OrderType < ::Types::BaseObject
     field :id, ID, null: false
     field :status, Integer, null: true
     field :total_amount, Types::ToDecimal,  null: false
     field :comments, String, null: true
     field :shipping_id, ID, null: false
     field :tax_id, ID, null: false
    end
  end
end

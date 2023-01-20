# frozen_string_literal: true

module Types
  module Models
    class Product::ProductType < ::Types::BaseObject
     field :id, ID, null: false
     field :name, String, null: false
     field :description, String, null: false
     field :price, Float, null: false
     field :discounted_price, Float,  null: false
     field :image, String, null: false
     field :image_2, String, null: false
     field :thumbnail, String, null: false
    end
  end
end

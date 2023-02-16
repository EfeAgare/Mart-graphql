module Types
  class Models::ShippingType < Types::BaseObject
    field :id, ID, null: false
    field :shipping_region_id, Types::ToInt, null: false
    field :cost,  Float, null: false
    field :type, String, null: false
  end
end
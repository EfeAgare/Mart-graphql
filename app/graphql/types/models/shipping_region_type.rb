module Types
  class Models::ShippingRegionType < Types::BaseObject
    field :id, ID, null: false
    field :region,  String, null: true
  end
end

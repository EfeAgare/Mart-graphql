module Queries
  class Shipping::FetchAllShippingRegions < Queries::BaseQuery

    type [Types::Models::ShippingRegionType], null: true
    
    def resolve(**attributes)
      shipping_region = ::ShippingRegion.all

      shipping_region
    end
  end
end

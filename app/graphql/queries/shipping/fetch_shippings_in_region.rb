module Queries
  class Shipping::FetchShippingsInRegion < Queries::BaseQuery

    argument :shipping_region_id, ID, required: true

    type [Types::Models::ShippingType], null: true

    def resolve(**params)
      shipping_info = ::Shipping.where(shipping_region_id: params[:shipping_region_id])

      shipping_info
    end
  end
end

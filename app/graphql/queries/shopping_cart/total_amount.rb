
module Queries
  class ShoppingCart::TotalAmount < Queries::BaseQuery
    argument :cart_id, ID, required: true

    type Types::Models::TotalAmountType, null: false

    def resolve(**params)
      shopping_cart = ::ShoppingCart.fetch_total_amount(params[:cart_id])

        
      { total_amount: shopping_cart }
    end
  end
end

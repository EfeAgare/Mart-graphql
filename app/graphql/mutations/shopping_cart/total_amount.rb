
module Mutations
  class ShoppingCart::TotalAmount < Mutations::BaseMutation
    argument :cart_id, ID, required: true

    field :total_amount, Types::ToDecimal, null: false

    def resolve(**params)
      shopping_cart = ::ShoppingCart.fetch_total_amount(params[:cart_id])

        
      { total_amount: shopping_cart }
    end
  end
end

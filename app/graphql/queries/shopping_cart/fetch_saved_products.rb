module Queries
  class ShoppingCart::FetchSavedProducts < Queries::BaseQuery

    argument :cart_id, String, required: true

    type [Types::Models::ShoppingCartType], null: true

    def resolve(**params)

      shopping_cart = ::ShoppingCart.joins(:product).where(cart_id: params[:cart_id]).where.not(buy_now: true)

      shopping_cart
    end
  end
end

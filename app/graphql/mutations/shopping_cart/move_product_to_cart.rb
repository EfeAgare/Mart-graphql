module Mutations
  class ShoppingCart::MoveProductToCart < Mutations::BaseMutation
    argument :id, ID, required: true

    type Types::Models::ShoppingCartType

    def resolve(**params)
      shopping_cart = ::ShoppingCart.find(params[:id])

        if shopping_cart.present?
          shopping_cart.update(buy_now: true)
        end

      shopping_cart
    rescue ActiveRecord::RecordNotFound => e
      not_found(e)
    end
  end
end

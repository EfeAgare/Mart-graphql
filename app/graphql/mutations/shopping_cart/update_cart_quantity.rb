module Mutations
  class ShoppingCart::UpdateCartQuantity < Mutations::BaseMutation
    argument :quantity, Types::ToInt, required: true
    argument :cart_id, String, required: true

    field :message, String, null: false

    def resolve(**params)
      shopping_cart = ::ShoppingCart.find_by(cart_id: params[:cart_id])

      if shopping_cart.present?
        if shopping_cart&.quantity > 0
          shopping_cart.update(quantity: shopping_cart&.quantity + params[:quantity])
        else
          shopping_cart.delete
        end

        { message: "Cart quantity updated"}
      else
        not_found("Cart with id=#{params[:cart_id]} not found")
      end
    end
  end
end

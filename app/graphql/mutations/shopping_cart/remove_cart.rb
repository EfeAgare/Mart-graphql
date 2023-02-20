module Mutations
  class ShoppingCart::RemoveCart < Mutations::BaseMutation
    argument :cart_id, ID, required: true

    field :message, String, null: false

    def resolve(**params)
      shopping_cart = ::ShoppingCart.find_by(cart_id: params[:cart_id])

      if shopping_cart.present?
        shopping_cart.delete
        { message: "Cart removed successfully"}
      else
        not_found("Cart with id=#{params[:cart_id]} not found")
      end
    end
  end
end

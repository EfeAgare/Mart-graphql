module Mutations
  class ShoppingCart::MoveProductToCart < Mutations::BaseMutation
    argument :cart_id, String, required: true
    argument :product_id, ID, required: true

    field :message, String, null: false

    def resolve(**params)
      shopping_cart = ::ShoppingCart.find_by(cart_id: params[:cart_id], product_id: params[:product_id])

     if shopping_cart.present?
        shopping_cart.delete
        { message: "Product removed from Cart removed successfully"}
      else
        not_found("Cart with id=#{params[:cart_id]} not found")
      end
    end
  end
end

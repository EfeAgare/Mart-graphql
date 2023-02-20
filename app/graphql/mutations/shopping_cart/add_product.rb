module Mutations
  class ShoppingCart::AddProduct < Mutations::BaseMutation
    argument :cart_id, String, required: true
    argument :product_id, ID, required: true
    argument :attributes, String, required: true
    argument :quantity, Types::ToInt, required: true
    argument :added_on, GraphQL::Types::ISO8601Date, required: true

    type Types::Models::ShoppingCartType

    def resolve(**params)
      shopping_cart = ::ShoppingCart.find_by(cart_id: params[:cart_id])

      if shopping_cart.present?
        quantity = shopping_cart&.quantity + (params[:quantity] || 1)
        shopping_cart.update(quantity: quantity, buy_now: true)

        shopping_cart 
      else
        shopping_cart = ::ShoppingCart.new(params)

        if shopping_cart.save
          shopping_cart 
        else
          unprocessable_entity(shopping_cart&.errors.full_messages)
        end
      end
    end
  end
end

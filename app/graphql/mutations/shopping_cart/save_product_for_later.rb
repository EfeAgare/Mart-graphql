module Mutations
  class ShoppingCart::SaveProductForLater < Mutations::BaseMutation
    argument :id, ID, required: true

    field :message, String, null: false

    def resolve(**params)
      shopping_cart = ::ShoppingCart.find(params[:id])

        if shopping_cart.present?
          shopping_cart.update(quantity: 1, buy_now: false)
        end

        shopping_cart

        { message: "Product saved for later" }
      rescue ActiveRecord::RecordNotFound => e
        not_found(e)
      end
    end
  end
end

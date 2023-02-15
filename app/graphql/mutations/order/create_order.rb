module Mutations
  class Order::CreateOrder < Mutations::BaseMutation
    argument :cart_id, String, required: true
    argument :shipping_id, ID, required: true
    argument :tax_id, ID, required: true
    argument :customer_id, ID, required: true

    type Types::Models::Order::OrderType

    def resolve(**attributes)
      attributes[:total_amount] = 1.0
      order = ::Order.new(attributes.except(:cart_id))

      ActiveRecord::Base.transaction do
        order.save!
        
        order_detail = ::OrderDetail.create_order(order.id, attributes[:cart_id])

        total_amount = order_detail.sum("unit_cost * quantity")
        order.update!(total_amount: total_amount)

        shopping_cart = ::ShoppingCart.find_by(cart_id: attributes[:cart_id])

        shopping_cart.destroy

      rescue ActiveRecord::RecordInvalid => exception 
        unprocessable_entity(order.errors.full_messages)
      end

      order
    end
  end
end

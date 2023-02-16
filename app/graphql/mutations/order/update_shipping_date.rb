module Mutations
  class Order::UpdateShippingDate < Mutations::BaseMutation
    argument :id, ID, required: true

    type Types::Models::Order::OrderType

    def resolve(**params)
      order = ::Order.find(params[:id])

      if order.update(shipped_on: Time.zone.now)
        order
      else
        unprocessable_entity(order.errors.full_messages)
      end

    rescue ActiveRecord::RecordNotFound => e
      not_found(e)
    end
  end
end

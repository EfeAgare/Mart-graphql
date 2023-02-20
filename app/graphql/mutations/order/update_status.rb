module Mutations
  class Order::UpdateStatus < Mutations::BaseMutation
    argument :status, Types::ToInt, required: true
    argument :id, ID, required: true

    type Types::Models::Order::OrderType

    def resolve(**params)
      order = ::Order.find(params[:id])

      if order.update(status: params[:status])
        order
      else
        unprocessable_entity(order.errors.full_messages)
      end
    rescue ActiveRecord::RecordNotFound => e
      not_found(e)
    end
  end
end

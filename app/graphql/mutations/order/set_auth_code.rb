module Mutations
  class Order::SetAuthCode < Mutations::BaseMutation
    argument :auth_code, String, required: true
    argument :reference, String, required: true
    argument :id, ID, required: true

    type Types::Models::Order::OrderType

    def resolve(**params)
      order = ::Order.find(params[:id])

      if order.update(auth_code: params[:auth_code], reference: params[:reference])
        order
      else
        unprocessable_entity(order.errors.full_messages)
      end

    rescue ActiveRecord::RecordNotFound => e
      not_found(e)
    end
  end
end

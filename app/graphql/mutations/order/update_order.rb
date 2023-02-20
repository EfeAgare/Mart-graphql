module Mutations
  class Order::UpdateOrder < Mutations::BaseMutation
    argument :status, Types::ToInt, required: true
    argument :auth_code, String, required: true
    argument :reference, String, required: true
    argument :comments, String, required: true
    argument :id, ID, required: true

    type Types::Models::Order::OrderType, null: true

    def resolve(**params)
      order = ::Order.find(params[:id])

      if order.update(params.except(:id))
        order
      else
        unprocessable_entity(order.errors.full_messages)
      end
    rescue ActiveRecord::RecordNotFound => e
      not_found(e)
    end
  end
end

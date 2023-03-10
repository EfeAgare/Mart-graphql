module Mutations
  class Customer::UpdateCustomerDetails < Mutations::BaseMutation

    argument :name, String, required: true
    argument :mobile_phone, String, required: true

    type Types::Models::CustomerType

    def resolve(**attributes)
      return not_found("User not found") unless current_user.present?

      if current_user.update(attributes)
        current_user
      else
        unprocessable_entity(current_user.errors.full_messages)
      end
    end

    def current_user
      context[:current_user]
    end
  end
end

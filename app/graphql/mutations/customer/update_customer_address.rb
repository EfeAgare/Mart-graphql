module Mutations
  class Customer::UpdateCustomerAddress < Mutations::BaseMutation
    argument :country, String, required: true
    argument :postal_code, String, required: true
    argument :region, String, required: true
    argument :city, String, required: true
    argument :address_2, String, required: true
    argument :address_1, String, required: true
    argument :shipping_region_id, Int, required: true

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

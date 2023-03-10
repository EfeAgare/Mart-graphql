module Mutations
  class Customer::UpdateCustomerCreditCard < Mutations::BaseMutation

    argument :credit_card, String, required: true
 
    type Types::Models::CustomerType

    def resolve(**attributes)

      return not_found("User not found") unless current_user.present?

      detector = CreditCardValidations::Detector.new(attributes[:credit_card])

      if detector.valid?
        if current_user.update(attributes)
          current_user
        else
          unprocessable_entity(current_user.errors.full_messages)
        end
      else
        unprocessable_entity("Invalid credit card")
      end
    end

    def current_user
      context[:current_user]
    end
  end
end

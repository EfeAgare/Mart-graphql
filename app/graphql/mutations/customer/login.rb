module Mutations
  class Customer::Login < Mutations::BaseMutation
    
    description "Login a user"

    argument :email, String, required: true
    argument :password, String, required: true

    type Types::Models::CustomerType

    def self.authorized?(object, context)
      true
    end

    def resolve(**attributes)
      customer = ::Customer.find_by(email: attributes[:email].downcase)

      if customer.present? && customer.valid_password?(attributes[:password])
        token = ::GenerateToken.new.call(customer)
        customer.serializable_hash.merge(token: token)
      else
        not_found("User not found or not registered yet")
      end
    end
  end
end

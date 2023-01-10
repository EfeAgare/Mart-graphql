module Mutations
  class Customer::Register < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :name, String, required: true

    type Types::Models::CustomerType

    def self.authorized?(object, context)
      true
    end

    def resolve(**attributes)
      customer = ::Customer.find_by(email: attributes[:email].downcase)

      conflict("User exist's") if customer.present? 

      new_customer = ::Customer.new(attributes)

      if new_customer.save
        token = ::GenerateToken.new.call(new_customer)
        new_customer.serializable_hash.merge(token: token)
      else
        unprocessable_entity(new_customer.errors.full_messages)
      end
    end
  end
end

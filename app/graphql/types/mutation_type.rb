module Types
  class MutationType < Types::BaseObject

    # Customer
    field :register, mutation: Mutations::Customer::Register
    field :login, mutation: Mutations::Customer::Login
    field :update_customer_address, mutation: Mutations::Customer::UpdateCustomerAddress
    field :update_customer_credit_card, mutation: Mutations::Customer::UpdateCustomerCreditCard
    field :update_customer_details, mutation: Mutations::Customer::UpdateCustomerAddress
  end
end

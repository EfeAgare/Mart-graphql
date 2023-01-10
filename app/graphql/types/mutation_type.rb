module Types
  class MutationType < Types::BaseObject

    # Customer
    field :register, mutation: Mutations::Customer::Register
    field :login, mutation: Mutations::Customer::Login
  end
end

module Types
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Customer::Register
    
  end
end

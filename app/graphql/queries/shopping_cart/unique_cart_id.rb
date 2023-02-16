module Queries
  class ShoppingCart::UniqueCartId < Queries::BaseQuery

    type Types::Models::UniqueCartIdType, null: false

    def resolve(**attributes)
      {
        cart_id: ::Devise.friendly_token(10)
      } 
    end
  end
end
